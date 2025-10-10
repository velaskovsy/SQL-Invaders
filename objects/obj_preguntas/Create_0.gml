randomize();

//Variables de control
pregunta_actual = 0;
respuesta_seleccionada = -1;
quizActivo = false;
preguntaActiva = false;
global.respCntrl = false;
contadorPreguntas = 0;
maxPreguntas = 3;
estado = "esperando";
respuesta_evaluada = false;
Aciertos = 0;


// variables para feedback
respuesta_correcta = false;


//Textos
texto = "";
resp1    = "";
resp2	 = "";
resp3	 = "";
resp4	 = "";


// Banco de preguntas
preguntas = [
    {
        texto: "La nave registra los disparos por planeta. ¿Cuál consulta muestra el total de disparos por planeta?",
        opciones: [
            "SELECT planeta, SUM(cantidad) FROM disparos;",
            "SELECT planeta, SUM(cantidad) FROM disparos GROUP BY planeta;",
            "SELECT SUM(cantidad) FROM disparos GROUP BY planeta;",
            "SELECT planeta FROM disparos;"
        ],
        correcta: 1,
		feedback: "Recuerda que para obtener el total de disparos por planeta necesitas aplicar la función de agregación SUM() y usar GROUP BY para separar los resultados por cada planeta."
    },
    {
        texto: "¿Qué cláusula se usa para filtrar antes del GROUP BY?",
        opciones: [
            "WHERE",
            "HAVING",
            "ORDER BY",
            "JOIN"
        ],
        correcta: 0,
		feedback: "lorem ipsum."
    }
];



crearPregunta = function(){
	quizActivo = true;
	pregunta_pausa();
	
	pregunta_actual = irandom(array_length(preguntas) - 1);
	var preg = preguntas [pregunta_actual];
	
	var prgnt = instance_create_layer(300, 200, "Instances", obj_preguntaRecuadro);
	prgnt.text[0] = preg.texto;
	
	var resp1 = instance_create_layer(300, 700, "Instances", obj_respuesta_Recuadro);
	resp1.text[0] = preg.opciones[0];
	resp1.indice_respuesta = 0;
	
	var resp2 = instance_create_layer(300, 900, "Instances", obj_respuesta_Recuadro);
	resp2.text[0] = preg.opciones[1];
	resp2.indice_respuesta = 1;

	var resp3 = instance_create_layer(300, 1100, "Instances", obj_respuesta_Recuadro);
	resp3.text[0] = preg.opciones[2];
	resp3.indice_respuesta = 2;
	
	var resp4 = instance_create_layer(300, 1300, "Instances", obj_respuesta_Recuadro);
	resp4.text[0] = preg.opciones[3];
	resp4.indice_respuesta = 3;
	
	preguntaActiva = true;

}

pregunta_pausa = function(){
	if (quizActivo = true){
		instance_deactivate_all(true); 
		instance_activate_object(obj_preguntas);
		instance_activate_object(obj_preguntaRecuadro);
		instance_activate_object(obj_respuesta_Recuadro);
		instance_activate_object(obj_textoPregunta);
	}
}

verificarRespuesta = function(indice) {
	
	if (!respuesta_evaluada) {
		var preg = preguntas[pregunta_actual];
	    if (indice == preguntas[pregunta_actual].correcta) {
	        score = score + 100;
			Aciertos++;
			global.balas += 10; // <-- Todavía no se cual valor puede ser
	    } 
		
		// Guardar resultado
        respuesta_correcta = (indice == preg.correcta);
		feedback_texto = preg.feedback;
		global.respCntrl = true;
		respuesta_evaluada = true;
		estado = "respuesta";
		
	}
}
mostrarFeedback = function() {
	var fb = instance_create_layer(200, 300, "Instances", obj_feedbackRecuadro);
	fb.text[0] = feedback_texto;
	var cntnr = instance_create_layer(750, 1200, "Instances", obj_boton_continuar);
	
	feedbackTimer = room_speed * 2;
};
