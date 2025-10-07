randomize();

//Variables de control
quizActivo = false;
pregunta_actual = 0;
respuesta_seleccionada = -1;
mostrar_feedback = false;
mensaje_feedback = "";
quizActivo = false;
global.respCntrl = false;


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
        correcta: 1
    },
    {
        texto: "¿Qué cláusula se usa para filtrar antes del GROUP BY?",
        opciones: [
            "WHERE",
            "HAVING",
            "ORDER BY",
            "JOIN"
        ],
        correcta: 0
    }
];



crearPregunta = function(){
	quizActivo = true;
	
	pregunta_actual = irandom(array_length(preguntas) - 1);
	var preg = preguntas [pregunta_actual];
	
	var prgnt = instance_create_layer(300, 200, "Instances", obj_preguntaRecuadro);
	prgnt.text[0] = preg.texto;
	
	var resp1 = instance_create_layer(300, 700, "Instances", obj_respuesta_Recuadro);
	resp1.text[0] = preg.opciones[0];
	
	var resp2 = instance_create_layer(300, 900, "Instances", obj_respuesta_Recuadro);
	resp2.text[0] = preg.opciones[1];

	var resp3 = instance_create_layer(300, 1100, "Instances", obj_respuesta_Recuadro);
	resp3.text[0] = preg.opciones[2];
	
	var resp4 = instance_create_layer(300, 1300, "Instances", obj_respuesta_Recuadro);
	resp4.text[0] = preg.opciones[3];

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