randomize();

//Variables de control
quizActivo = false;

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

// Variables de control
pregunta_actual = 0;
respuesta_seleccionada = -1;
mostrar_feedback = false;
mensaje_feedback = "";
quizActivo = false;


crearPregunta = function(){
	quizActivo = true;
	
	pregunta_actual = irandom(array_length(preguntas) - 1);
	var preg = preguntas [pregunta_actual];
	
	var prgnt = instance_create_layer(400, 200, "Instances", obj_preguntaRecuadro);
	prgnt.text = preg.texto;
	
	var resp1 = instance_create_layer(300, 700, "Instances", obj_respuesta_Recuadro);
	
	var resp2 = instance_create_layer(300, 900, "Instances", obj_respuesta_Recuadro);

	var resp3 = instance_create_layer(300, 1100, "Instances", obj_respuesta_Recuadro);

	var resp4 = instance_create_layer(300, 1300, "Instances", obj_respuesta_Recuadro);
	

}