// ----------------------
// Create Event de obj_preguntas
// ----------------------

randomize();

// Variables de control
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

// Variables para feedback
respuesta_correcta = false;

// Textos
texto = "";
resp1    = "";
resp2    = "";
resp3    = "";
resp4    = "";

// ----------------------
// Banco de preguntas por nivel (room)
// ----------------------

preguntas = [];

switch(room) {
    case rm_play0: // Nivel 1
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
	            feedback: "Para obtener el total de disparos por planeta necesitas aplicar la función de agregación SUM() y usar GROUP BY para separar los resultados por cada planeta."
	        },
	        {
	            texto: "En la base invasores(tipo, id), ¿cuál consulta cuenta invasores por tipo?",
	            opciones: [
	                "SELECT tipo, COUNT() FROM invasores;",
	                "SELECT tipo, COUNT() FROM invasores GROUP BY tipo;",
	                "SELECT COUNT(*) FROM invasores GROUP BY tipo;",
	                "SELECT tipo FROM invasores;"
	            ],
	            correcta: 1,
	            feedback: "Para contar invasores por tipo es necesario usar COUNT() junto con GROUP BY, así cada tipo tendrá su propio conteo."
	        },
	        {
	            texto: "Queremos saber el número de pilotos por planeta.",
	            opciones: [
	                "SELECT planeta, COUNT() FROM pilotos GROUP BY planeta;",
	                "SELECT planeta, COUNT() FROM pilotos;",
	                "SELECT COUNT(*) FROM pilotos;",
	                "SELECT planeta FROM pilotos;"
	            ],
	            correcta: 0,
	            feedback: "Para obtener el número de pilotos por planeta se usa COUNT() junto con GROUP BY, agrupando por la columna planeta."
	        },
	        {
	            texto: "¿Cómo mostramos el promedio de rayos disparados por nave?",
	            opciones: [
	                "SELECT nave, AVG(rayos) FROM disparos GROUP BY nave;",
	                "SELECT AVG(rayos) FROM disparos;",
	                "SELECT nave, rayos FROM disparos;",
	                "SELECT rayos, AVG(nave) FROM disparos GROUP BY nave;"
	            ],
	            correcta: 0,
	            feedback: "El promedio por nave se obtiene aplicando AVG() sobre los rayos y agrupando por la columna nave con GROUP BY."
	        },
	        {
	            texto: "Los planetas tienen registros de escudos. Mostrar escudo máximo por planeta.",
	            opciones: [
	                "SELECT planeta, escudo FROM registros;",
	                "SELECT planeta, MAX(escudo) FROM registros GROUP BY planeta;",
	                "SELECT MAX(escudo) FROM registros;",
	                "SELECT planeta, MAX(escudo) FROM registros;"
	            ],
	            correcta: 1,
	            feedback: "Para mostrar el escudo máximo por planeta se utiliza MAX() junto con GROUP BY, de manera que cada planeta muestre su valor más alto."
	        }
	    ];
	break;


    case rm_play1: // Nivel 2
	    preguntas = [
	        {
	            texto: "Listar comandantes con más de 5 naves.",
	            opciones: [
	                "SELECT comandante FROM naves HAVING COUNT() > 5;",
	                "SELECT comandante, COUNT() FROM naves WHERE COUNT() > 5;",
	                "SELECT comandante, COUNT() FROM naves GROUP BY comandante;",
	                "SELECT c.nombre, COUNT(n.id) FROM comandantes c JOIN naves n ON c.id = n.id_comandante GROUP BY c.nombre HAVING COUNT(n.id) > 5;"
	            ],
	            correcta: 3,
	            feedback: "Aquí se combinan dos tablas (comandantes y naves) con JOIN. Luego se agrupa por nombre del comandante y HAVING filtra a los que tienen más de 5 naves."
	        },
	        {
	            texto: "Mostrar planetas atacados con más de 100 rayos.",
	            opciones: [
	                "SELECT p.nombre, SUM(a.rayos) FROM planetas p JOIN ataques a ON p.id=a.id_planeta GROUP BY p.nombre HAVING SUM(a.rayos) > 100;",
	                "SELECT planeta, SUM(rayos) FROM ataques WHERE SUM(rayos) > 100;",
	                "SELECT planeta, SUM(rayos) FROM ataques GROUP BY planeta;",
	                "SELECT planeta FROM ataques HAVING SUM(rayos) > 100;"
	            ],
	            correcta: 0,
	            feedback: "Se combinan planetas y ataques. El SUM() se coloca con GROUP BY, y HAVING filtra los planetas con más de 100 rayos."
	        },
	        {
	            texto: "Mostrar sectores con promedio de energía mayor a 2000.",
	            opciones: [
	                "SELECT s.nombre, AVG(e.energia) FROM sectores s JOIN estaciones e ON s.id=e.id_sector GROUP BY s.nombre HAVING AVG(e.energia) > 2000;",
	                "SELECT sector, AVG(energia) FROM estaciones WHERE AVG(energia) > 2000;",
	                "SELECT sector, AVG(energia) FROM estaciones GROUP BY energia;",
	                "SELECT sector FROM estaciones HAVING energia > 2000;"
	            ],
	            correcta: 0,
	            feedback: "El promedio se calcula con AVG() después de unir sectores y estaciones. HAVING filtra solo los sectores con un promedio mayor a 2000."
	        },
	        {
	            texto: "Mostrar modelos de nave con al menos 3 pilotos asignados.",
	            opciones: [
	                "SELECT modelo, COUNT(*) FROM pilotos GROUP BY piloto;",
	                "SELECT modelo, COUNT() FROM pilotos WHERE COUNT() >= 3;",
	                "SELECT modelo, COUNT() FROM pilotos GROUP BY modelo HAVING COUNT() >= 3;",
	                "SELECT n.modelo, COUNT(p.id) FROM naves n JOIN pilotos p ON n.id=p.id_nave GROUP BY n.modelo HAVING COUNT(p.id) >= 3;"
	            ],
	            correcta: 3,
	            feedback: "Es necesario unir naves y pilotos, agrupar por modelo de nave y usar HAVING para mostrar solo las que tienen al menos 3 pilotos asignados."
	        },
	        {
	            texto: "Planetas con más de 2 invasores tipo “élite”.",
	            opciones: [
	                "SELECT planeta FROM invasores WHERE COUNT() > 2;",
	                "SELECT planeta, COUNT() FROM invasores GROUP BY tipo HAVING COUNT() > 2;",
	                "SELECT planeta, COUNT() FROM invasores HAVING tipo='élite';",
	                "SELECT p.nombre, COUNT(i.id) FROM planetas p JOIN invasores i ON p.id=i.id_planeta WHERE i.tipo='élite' GROUP BY p.nombre HAVING COUNT(i.id) > 2;"
	            ],
	            correcta: 3,
	            feedback: "Primero se filtran los invasores de tipo “élite” con WHERE. Luego se agrupan por planeta y HAVING aplica la condición sobre el conteo."
	        }
	    ];
	break;


    case rm_play2: // Nivel 3
	    preguntas = [
	        {
	            texto: "Naves por modelo y escuadrón con más de 10 victorias.",
	            opciones: [
	                "SELECT modelo, escuadron, COUNT() FROM naves GROUP BY modelo, escuadron HAVING COUNT() > 10;",
	                "SELECT modelo, escuadron, COUNT() FROM naves WHERE COUNT() > 10;",
	                "SELECT modelo, escuadron, COUNT() FROM naves GROUP BY modelo HAVING COUNT() > 10;",
	                "SELECT n.modelo, e.nombre, COUNT(v.id) FROM naves n JOIN escuadrones e ON n.id_escuadron=e.id JOIN victorias v ON n.id=v.id_nave GROUP BY n.modelo, e.nombre HAVING COUNT(v.id) > 10;"
	            ],
	            correcta: 3,
	            feedback: "Se usan tres tablas (naves, escuadrones, victorias). Se agrupa por modelo y escuadrón y HAVING filtra los que superan 10 victorias."
	        },
	        {
	            texto: "Sectores con más de 5 estaciones y energía promedio > 2000.",
	            opciones: [
	                "SELECT sector, COUNT(), AVG(energia) FROM estaciones WHERE COUNT() > 5 AND AVG(energia) > 2000;",
	                "SELECT s.nombre, COUNT(e.id), AVG(e.energia) FROM sectores s JOIN estaciones e ON s.id=e.id_sector JOIN mediciones m ON e.id=m.id_estacion GROUP BY s.nombre HAVING COUNT(e.id) > 5 AND AVG(m.energia) > 2000;",
	                "SELECT sector, COUNT(*), AVG(energia) FROM estaciones GROUP BY energia;",
	                "SELECT sector FROM estaciones HAVING energia > 2000;"
	            ],
	            correcta: 1,
	            feedback: "Al unir sectores, estaciones y mediciones se puede contar y promediar. HAVING permite aplicar ambas condiciones al mismo tiempo."
	        },
	        {
	            texto: "Mostrar comandantes con más de 3 naves y menos de 2 derrotas.",
	            opciones: [
	                "SELECT comandante FROM naves HAVING derrotas < 2;",
	                "SELECT comandante, COUNT() FROM naves WHERE COUNT() > 3;",
	                "SELECT comandante, COUNT(*) FROM naves GROUP BY derrotas;",
	                "SELECT c.nombre, COUNT(n.id), SUM(b.derrotas) FROM comandantes c JOIN naves n ON c.id=n.id_comandante JOIN batallas b ON n.id=b.id_nave GROUP BY c.nombre HAVING COUNT(n.id) > 3 AND SUM(b.derrotas) < 2;"
	            ],
	            correcta: 3,
	            feedback: "Se unen comandantes, naves y batallas. HAVING permite combinar condiciones sobre COUNT() y SUM() al mismo tiempo."
	        },
	        {
	            texto: "Mostrar planetas donde se lanzaron más de 50 rayos y menos de 5 invasores llegaron vivos.",
	            opciones: [
	                "SELECT planeta FROM batallas GROUP BY rayos;",
	                "SELECT planeta, SUM(rayos) FROM batallas WHERE SUM(rayos) > 50;",
	                "SELECT planeta, SUM(rayos), COUNT(invasores) FROM batallas GROUP BY planeta HAVING SUM(rayos) > 50 AND COUNT(invasores) < 5;",
	                "SELECT p.nombre, SUM(b.rayos), COUNT(i.id) FROM planetas p JOIN batallas b ON p.id=b.id_planeta JOIN invasores i ON b.id=i.id_batalla GROUP BY p.nombre HAVING SUM(b.rayos) > 50 AND COUNT(i.id) < 5;"
	            ],
	            correcta: 3,
	            feedback: "Se necesitan tres tablas (planetas, batallas, invasores). El filtrado se hace en HAVING con dos condiciones combinadas."
	        },
	        {
	            texto: "Modelos de nave con velocidad promedio > 5000 y más de 10 pilotos asignados.",
	            opciones: [
	                "SELECT modelo FROM naves WHERE velocidad > 5000;",
	                "SELECT modelo, AVG(velocidad), COUNT() FROM naves GROUP BY modelo HAVING AVG(velocidad) > 5000 AND COUNT() > 10;",
	                "SELECT modelo FROM naves GROUP BY piloto;",
	                "SELECT n.modelo, AVG(n.velocidad), COUNT(p.id) FROM naves n JOIN pilotos p ON n.id=p.id_nave JOIN pruebas pr ON n.id=pr.id_nave GROUP BY n.modelo HAVING AVG(pr.velocidad) > 5000 AND COUNT(p.id) > 10;"
	            ],
	            correcta: 3,
	            feedback: "Al unir naves, pilotos y pruebas se puede calcular la velocidad promedio y el número de pilotos. HAVING permite aplicar ambas restricciones."
	        }
	    ];
	break;


    default:
        // Pregunta por defecto si la room no coincide
        preguntas = [
            {
                texto: "Pregunta por defecto: ¿Qué es SQL?",
                opciones: ["Lenguaje de marcas", "Lenguaje de consulta", "Sistema operativo", "Editor de texto"],
                correcta: 1,
                feedback: "SQL es Structured Query Language, usado para consultar bases de datos."
            }
        ];
    break;
}

// ----------------------
// Funciones del quiz
// ----------------------

// Crear pregunta en pantalla
crearPregunta = function(){
    quizActivo = true;
    pregunta_pausa();
    
    // Elegir pregunta aleatoria del nivel actual
    if (array_length(preguntas) == 0) {
        // fallback
        preguntas = [{
            texto: "Pregunta por defecto",
            opciones: ["A","B","C","D"],
            correcta: 0,
            feedback: "No había preguntas definidas para este nivel."
        }];
    }

    pregunta_actual = irandom(array_length(preguntas) - 1);
    var preg = preguntas[pregunta_actual];
    
    // Crear cuadro de pregunta
    var prgnt = instance_create_layer(300, 200, "Instances", obj_preguntaRecuadro);
    prgnt.text[0] = preg.texto;
    
    // Crear opciones
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

// Pausar instancias del juego mientras el quiz está activo
pregunta_pausa = function(){
    if (quizActivo == true){
        instance_deactivate_all(true); 
        instance_activate_object(obj_preguntas);
        instance_activate_object(obj_preguntaRecuadro);
        instance_activate_object(obj_respuesta_Recuadro);
        instance_activate_object(obj_textoPregunta);
    }
}

// Verificar respuesta seleccionada
verificarRespuesta = function(indice) {
    if (!respuesta_evaluada) {
        var preg = preguntas[pregunta_actual];
        if (indice == preg.correcta) {
            score += 100;
            Aciertos++;
            global.balas += 10; // recompensa por respuesta correcta
        } 
        
        // Guardar resultado y mostrar feedback
        respuesta_correcta = (indice == preg.correcta);
        feedback_texto = preg.feedback;
        global.respCntrl = true;
        respuesta_evaluada = true;
        estado = "respuesta";
    }
}

// Mostrar feedback en pantalla
mostrarFeedback = function() {
    var fb = instance_create_layer(200, 300, "Instances", obj_feedbackRecuadro);
    fb.text[0] = feedback_texto;
    var cntnr = instance_create_layer(750, 1200, "Instances", obj_boton_continuar);
    
    feedbackTimer = room_speed * 2;
};

// Continuar quiz: siguiente pregunta o finalizar
continuarQuiz = function() {
    contadorPreguntas++;

    if (contadorPreguntas < maxPreguntas) {
        respuesta_evaluada = false;
        global.respCntrl = false;
        estado = "esperando";

        // limpiar feedback antes de crear la siguiente pregunta
        with (obj_feedbackRecuadro) instance_destroy();
        with (obj_boton_continuar) instance_destroy();
        with (obj_textoPregunta) instance_destroy();

        crearPregunta();
    } else {
        ir_a_juego_principal();
    }
};

// Volver al juego principal
ir_a_juego_principal = function() {
    instance_activate_all();
    
    with (obj_preguntaRecuadro) instance_destroy();
    with (obj_respuesta_Recuadro) instance_destroy();
    with (obj_feedbackRecuadro) instance_destroy();
    with (obj_boton_continuar) instance_destroy();
    with (obj_textoPregunta) instance_destroy();
    
    quizActivo = false;
    global.respCntrl = false;
    respuesta_evaluada = false;
    preguntaActiva = false;
    estado = "esperando";
    contadorPreguntas = 0;
};
