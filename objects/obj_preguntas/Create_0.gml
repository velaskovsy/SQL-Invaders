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
global.puntaje = 0;

// Variables para feedback
respuesta_correcta = false;

// NUEVO: Array para rastrear preguntas ya mostradas
preguntas_usadas = [];

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
	        },
			{
			    texto: "¿Cómo mostramos la suma de rayos disparados por cada planeta?",
			    opciones: [
			        "SELECT planeta, SUM(rayos) FROM disparos;", 
			        "SELECT planeta, SUM(rayos) FROM disparos GROUP BY planeta;", 
			        "SELECT SUM(rayos) FROM disparos GROUP BY planeta;", 
			        "SELECT planeta FROM disparos;"
			    ],
			    correcta: 1,
			    feedback: "Es necesario agrupar los registros por planeta usando GROUP BY para que SUM() sume los rayos de cada planeta por separado. La opción A suma todos los rayos pero no los agrupa; la C agrupa pero no muestra el planeta."
			},
			{
			    texto: "Obtener el promedio de energía por nave.",
			    opciones: [
			        "SELECT nave, AVG(energia) FROM naves GROUP BY nave;", 
			        "SELECT AVG(energia) FROM naves;", 
			        "SELECT nave, energia FROM naves;", 
			        "SELECT AVG(nave) FROM naves GROUP BY energia;"
			    ],
			    correcta: 0,
			    feedback: "AVG() calcula el promedio de energía y GROUP BY nave permite que el promedio se haga por cada nave individual. Las otras opciones no agrupan correctamente o usan sintaxis inválida."
			},
			{
			    texto: "Número de pilotos por rango.",
			    opciones: [
			        "SELECT rango, COUNT(*) FROM pilotos GROUP BY rango;", 
			        "SELECT COUNT(*) FROM pilotos;", 
			        "SELECT rango, COUNT(*) FROM pilotos;", 
			        "SELECT rango FROM pilotos;"
			    ],
			    correcta: 0,
			    feedback: "COUNT(*) junto a GROUP BY rango permite contar cuántos pilotos hay en cada rango. La opción 1 da el total de todos los pilotos, y la opción 2 no agrupa."
			},
			{
			    texto: "Mostrar el máximo de combustible usado por modelo de nave.",
			    opciones: [
			        "SELECT modelo, MAX(combustible) FROM naves GROUP BY modelo;", 
			        "SELECT modelo, combustible FROM naves;", 
			        "SELECT MAX(combustible) FROM naves;", 
			        "SELECT modelo FROM naves;"
			    ],
			    correcta: 0,
			    feedback: "MAX() permite obtener el valor más alto de combustible, pero necesitamos GROUP BY modelo para que el máximo sea por cada modelo. Las demás opciones o no agrupan o no muestran el modelo."
			},
			{
			    texto: "Promedio de edad de comandantes por planeta.",
			    opciones: [
			        "SELECT planeta, AVG(edad) FROM comandantes GROUP BY planeta;", 
			        "SELECT AVG(edad) FROM comandantes;", 
			        "SELECT planeta, SUM(edad) FROM comandantes;", 
			        "SELECT planeta FROM comandantes GROUP BY edad;"
			    ],
			    correcta: 0,
			    feedback: "AVG() calcula el promedio y GROUP BY planeta lo separa por cada planeta. La opción 1 da un promedio global, y las demás no hacen la agrupación correcta."
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
	            texto: "Planetas con más de 2 invasores tipo élite",
	            opciones: [
	                "SELECT planeta FROM invasores WHERE COUNT() > 2;",
	                "SELECT planeta, COUNT() FROM invasores GROUP BY tipo HAVING COUNT() > 2;",
	                "SELECT planeta, COUNT() FROM invasores HAVING tipo='élite';",
	                "SELECT p.nombre, COUNT(i.id) FROM planetas p JOIN invasores i ON p.id=i.id_planeta WHERE i.tipo='élite' GROUP BY p.nombre HAVING COUNT(i.id) > 2;"
	            ],
	            correcta: 3,
	            feedback: "Primero se filtran los invasores de tipo élite con WHERE. Luego se agrupan por planeta y HAVING aplica la condición sobre el conteo."
	        },
			{
			    texto: "Comandantes con más de 3 naves asignadas.",
			    opciones: [
			        "SELECT c.nombre, COUNT(n.id) FROM comandantes c JOIN naves n ON c.id=n.id_comandante GROUP BY c.nombre HAVING COUNT(n.id) > 3;", 
			        "SELECT c.nombre FROM comandantes c JOIN naves n;", 
			        "SELECT comandante, COUNT(*) FROM naves WHERE COUNT(*) > 3;", 
			        "SELECT nombre, COUNT(*) FROM naves;"
			    ],
			    correcta: 0,
			    feedback: "Se requiere JOIN para combinar comandantes y naves, GROUP BY para agrupar por comandante y HAVING para filtrar los que tienen más de 3 naves. Las demás opciones o no usan HAVING o no combinan las tablas correctamente."
			},
			{
			    texto: "Planetas donde la suma de ataques supera 50.",
			    opciones: [
			        "SELECT p.nombre, SUM(a.rayos) FROM planetas p JOIN ataques a ON p.id=a.id_planeta GROUP BY p.nombre HAVING SUM(a.rayos) > 50;", 
			        "SELECT nombre FROM planetas WHERE SUM(rayos) > 50;", 
			        "SELECT planeta, SUM(rayos) FROM ataques;", 
			        "SELECT planeta FROM ataques;"
			    ],
			    correcta: 0,
			    feedback: "JOIN permite relacionar planetas con ataques. SUM() calcula total de rayos y HAVING filtra planetas que superan 50. La opción B es incorrecta porque SUM() no se puede usar en WHERE."
			},
			{
			    texto: "Sectores con promedio de energía superior a 1500.",
			    opciones: [
			        "SELECT s.nombre, AVG(e.energia) FROM sectores s JOIN estaciones e ON s.id=e.id_sector GROUP BY s.nombre HAVING AVG(e.energia) > 1500;", 
			        "SELECT sector, AVG(energia) FROM estaciones WHERE AVG(energia) > 1500;", 
			        "SELECT AVG(energia) FROM estaciones;", 
			        "SELECT s.nombre FROM sectores;"
			    ],
			    correcta: 0,
			    feedback: "AVG() calcula el promedio, GROUP BY permite separar por sector y HAVING filtra sectores con promedio mayor a 1500. La opción B intenta usar AVG() en WHERE, lo cual es inválido."
			},
			{
			    texto: "Mostrar modelos de nave con al menos 2 pilotos.",
			    opciones: [
			        "SELECT n.modelo, COUNT(p.id) FROM naves n JOIN pilotos p ON n.id=p.id_nave GROUP BY n.modelo HAVING COUNT(p.id) >= 2;", 
			        "SELECT modelo, COUNT(*) FROM pilotos;", 
			        "SELECT n.modelo FROM naves;", 
			        "SELECT modelo, COUNT(*) FROM pilotos GROUP BY modelo;"
			    ],
			    correcta: 0,
			    feedback: "Se necesita unir naves y pilotos, agrupar por modelo y filtrar con HAVING los modelos con 2 o más pilotos. Las otras opciones no combinan las tablas ni filtran correctamente."
			},
			{
			    texto: "Planetas con más de 1 invasor tipo élite",
			    opciones: [
			        "SELECT p.nombre, COUNT(i.id) FROM planetas p JOIN invasores i ON p.id=i.id_planeta WHERE i.tipo='élite' GROUP BY p.nombre HAVING COUNT(i.id) > 1;", 
			        "SELECT planeta, COUNT(*) FROM invasores WHERE tipo='élite';", 
			        "SELECT planeta FROM invasores;", 
			        "SELECT p.nombre FROM planetas p JOIN invasores i ON p.id=i.id_planeta;"
			    ],
			    correcta: 0,
			    feedback: "Primero filtramos invasores tipo 'élite', luego agrupamos por planeta y aplicamos HAVING para seleccionar los que tienen más de 1. Las demás opciones no aplican correctamente HAVING ni COUNT()."
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
	        },
			{
			    texto: "Comandantes con más de 2 escuadrones y naves con más de 5 victorias.",
			    opciones: [
			        "SELECT c.nombre, COUNT(e.id), SUM(n.victorias) FROM comandantes c JOIN escuadrones e ON c.id=e.id_comandante JOIN naves n ON e.id=n.id_escuadron GROUP BY c.nombre HAVING COUNT(e.id) > 2 AND SUM(n.victorias) > 5;", 
			        "SELECT c.nombre, COUNT(n.id) FROM comandantes c JOIN naves n ON c.id=n.id_comandante;", 
			        "SELECT nombre FROM comandantes;", 
			        "SELECT c.nombre, SUM(n.victorias) FROM naves n JOIN escuadrones e ON n.id_escuadron=e.id;"
			    ],
			    correcta: 0,
			    feedback: "Se requiere combinar tres tablas y usar GROUP BY para agrupar por comandante. HAVING permite filtrar por número de escuadrones y victorias. Las otras opciones no aplican ambas condiciones o no agrupan correctamente."
			},
			{
			    texto: "Ciudades con promedio de ataques fallidos < 2 y defensas exitosas > 8.",
			    opciones: [
			        "SELECT ciu.nombre, AVG(a.fallidos), SUM(d.exitosas) FROM ciudades ciu JOIN ataques a ON ciu.id=a.id_ciudad JOIN defensas d ON ciu.id=d.id_ciudad GROUP BY ciu.nombre HAVING AVG(a.fallidos) < 2 AND SUM(d.exitosas) > 8;", 
			        "SELECT nombre FROM ciudades;", 
			        "SELECT ciu.nombre, COUNT(*) FROM ataques a;", 
			        "SELECT * FROM defensas d;"
			    ],
			    correcta: 0,
			    feedback: "Se necesitan tres tablas para calcular ambos valores. AVG() y SUM() permiten medir ataques fallidos y defensas exitosas respectivamente, y HAVING filtra según las condiciones establecidas."
			},
			{
			    texto: "Tipos de nave y regiones con misiones > 4 o velocidad promedio > 8000.",
			    opciones: [
			        "SELECT n.tipo, r.nombre, COUNT(m.id), AVG(n.velocidad) FROM naves n JOIN misiones m ON n.id=m.id_nave JOIN regiones r ON n.id_region=r.id GROUP BY n.tipo, r.nombre HAVING COUNT(m.id) > 4 OR AVG(n.velocidad) > 8000;", 
			        "SELECT tipo, COUNT(*) FROM naves;", 
			        "SELECT n.tipo FROM naves;", 
			        "SELECT r.nombre, AVG(n.velocidad) FROM regiones r JOIN naves n;"
			    ],
			    correcta: 0,
			    feedback: "El uso de tres tablas permite evaluar número de misiones y velocidad promedio. HAVING con OR filtra correctamente si se cumple alguna de las condiciones. Las demás opciones no combinan ni filtran correctamente."
			},
			{
			    texto: "Planetas con más de 40 rayos lanzados y menos de 3 invasores sobrevivientes.",
			    opciones: [
			        "SELECT p.nombre, SUM(b.rayos), COUNT(i.id) FROM planetas p JOIN batallas b ON p.id=b.id_planeta JOIN invasores i ON b.id=i.id_batalla GROUP BY p.nombre HAVING SUM(b.rayos) > 40 AND COUNT(i.id) < 3;", 
			        "SELECT planeta FROM batallas;", 
			        "SELECT SUM(rayos) FROM batallas;", 
			        "SELECT p.nombre, SUM(rayos) FROM planetas p JOIN batallas b ON p.id=b.id_planeta;"
			    ],
			    correcta: 0,
			    feedback: "Se combinan planetas, batallas e invasores. SUM() y COUNT() permiten medir rayos e invasores, y HAVING filtra según las condiciones. Las otras opciones no calculan ni filtran correctamente."
			},
			{
			    texto: "Modelos de nave con promedio de tripulantes > 5 y recursos totales usados > 20000.",
			    opciones: [
			        "SELECT n.modelo, AVG(n.tripulantes), SUM(r.costo_total) FROM naves n JOIN recursos r ON n.id=r.id_nave GROUP BY n.modelo HAVING AVG(n.tripulantes) > 5 AND SUM(r.costo_total) > 20000;", 
			        "SELECT modelo FROM naves;", 
			        "SELECT AVG(tripulantes) FROM naves;", 
			        "SELECT n.modelo, SUM(r.costo_total) FROM naves n JOIN recursos r ON n.id=r.id_nave;"
			    ],
			    correcta: 0,
			    feedback: "JOIN entre naves y recursos permite calcular tanto el promedio de tripulantes como la suma de recursos. GROUP BY modelo y HAVING aplican las condiciones requeridas. Las demás opciones no cumplen ambos criterios."
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

    // MODIFICADO: Elegir pregunta aleatoria que NO esté en preguntas_usadas
    var pregunta_disponible = false;
    var intentos = 0;
    
    while (!pregunta_disponible && intentos < 100) {
        pregunta_actual = irandom(array_length(preguntas) - 1);
        
        // Verificar si ya fue usada (sin usar array_find_index)
        var ya_usada = false;
        for (var i = 0; i < array_length(preguntas_usadas); i++) {
            if (preguntas_usadas[i] == pregunta_actual) {
                ya_usada = true;
                break;
            }
        }
        
        if (!ya_usada) {
            pregunta_disponible = true;
            // Agregar a la lista de usadas
            array_push(preguntas_usadas, pregunta_actual);
        }
        intentos++;
    }
    
    var preg = preguntas[pregunta_actual];
    
    // Crear cuadro de pregunta
    var prgnt = instance_create_layer(150, 200, "Instances", obj_preguntaRecuadro);
    prgnt.text[0] = preg.texto;
    
    // Crear opciones
    var resp1 = instance_create_layer(150, 600, "Instances", obj_respuesta_Recuadro);
    resp1.text[0] = preg.opciones[0];
    resp1.indice_respuesta = 0;
    
    var resp2 = instance_create_layer(150, 830, "Instances", obj_respuesta_Recuadro);
    resp2.text[0] = preg.opciones[1];
    resp2.indice_respuesta = 1;

    var resp3 = instance_create_layer(150, 1060, "Instances", obj_respuesta_Recuadro);
    resp3.text[0] = preg.opciones[2];
    resp3.indice_respuesta = 2;
    
    var resp4 = instance_create_layer(150, 1290, "Instances", obj_respuesta_Recuadro);
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
			global.puntaje += 100;
            Aciertos++;
            global.balas += 8; // recompensa por respuesta correcta
        } 
		else global.balas += 3;
        
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
    
    // NUEVO: Limpiar historial de preguntas usadas para el próximo quiz
    preguntas_usadas = [];
};