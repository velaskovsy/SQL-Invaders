switch (estado) {
    case "esperando":
        if (global.balas <= 0 && !quizActivo) {
            crearPregunta();
        }
    break;
    
    case "respuesta":
        // aquí se activa cuando el jugador hace clic
        // No hacemos nada aquí, dejamos que los objetos se autodestruyan
        if (!instance_exists(obj_preguntaRecuadro) && !instance_exists(obj_respuesta_Recuadro)) {
            mostrarFeedback();
            estado = "feedback";
        }
    break;
    
    case "feedback":
        // esperar unos segundos y pasar a la siguiente
        /*feedbackTimer--;
        if (feedbackTimer <= 0) {
            contadorPreguntas++;
            if (contadorPreguntas < maxPreguntas) {
                respuesta_evaluada = false;
                global.respCntrl = false;
                estado = "esperando";
            } else {
                ir_a_juego_principal();
            }
        }*/
    break;
}