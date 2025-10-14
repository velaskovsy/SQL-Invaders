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
                feedback: "Recuerda que para obtener el total de disparos por planeta necesitas aplicar SUM() y usar GROUP BY por planeta."
            },
            {
                texto: "¿Qué cláusula se usa para filtrar antes del GROUP BY?",
                opciones: ["WHERE", "HAVING", "ORDER BY", "JOIN"],
                correcta: 0,
                feedback: "WHERE filtra filas antes de agrupar; HAVING filtra después de agrupar."
            }
        ];
    break;

    case rm_play1: // Nivel 2
        preguntas = [
            {
                texto: "¿Cuál es la diferencia entre WHERE y HAVING?",
                opciones: [
                    "WHERE filtra después de agrupar, HAVING antes",
                    "WHERE filtra antes de agrupar, HAVING después",
                    "Ambas son iguales",
                    "HAVING es más rápido"
                ],
                correcta: 1,
                feedback: "WHERE filtra filas antes de aplicar GROUP BY; HAVING filtra grupos ya calculados."
            },
            {
                texto: "¿Qué hace SUM(columna) en una consulta con GROUP BY?",
                opciones: [
                    "Cuenta filas",
                    "Devuelve el total acumulado por grupo",
                    "Ordena los resultados",
                    "Divide los resultados"
                ],
                correcta: 1,
                feedback: "SUM suma los valores de la columna por cada grupo definido por GROUP BY."
            }
        ];
    break;

    case rm_play2: // Nivel 3
        preguntas = [
            {
                texto: "¿Cuál es un uso típico de HAVING?",
                opciones: [
                    "Filtrar filas por condición simple",
                    "Filtrar resultados agregados (ej. SUM > 100)",
                    "Cambiar el nombre de columnas",
                    "Unir tablas"
                ],
                correcta: 1,
                feedback: "HAVING se usa para condicionar resultados agregados, por ejemplo SUM(cantidad) > 100."
            },
            {
                texto: "¿Qué cláusula permite combinar filas de dos tablas?",
                opciones: ["WHERE", "GROUP BY", "JOIN", "HAVING"],
                correcta: 2,
                feedback: "JOIN combina filas de diferentes tablas según condiciones de unión."
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
