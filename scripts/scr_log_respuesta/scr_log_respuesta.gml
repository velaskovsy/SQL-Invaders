function scr_log_respuesta(timestamp, idJugador, pregunta, alternativas, respuestaJugador, esCorrecta, tiempoRespuesta, puntaje){
	
	var archivo = working_directory + "log_respuestas.csv";
	 
	var room_name = room_get_name(room);
    var nivel = "";

    switch (room_name) {
        case "rm_play0": nivel = "Nivel 1"; break;
        case "rm_play1": nivel = "Nivel 2"; break;
        case "rm_play2": nivel = "Nivel 3"; break;
        default: nivel = room_name; break; 
    }
	
	// Si el archivo no existe, lo creamos con encabezado
	if (!file_exists(archivo)) {
	    var f_init = file_text_open_write(archivo);
	    file_text_write_string(f_init, "timestamp,idJugador,nivel,pregunta,alternativas,respuestaJugador,esCorrecta,tiempoRespuesta,puntaje\n");
	    file_text_close(f_init);
	}

	// Abrir archivo y añadir una línea
	var f = file_text_open_append(archivo);
	var linea = string(timestamp) + "," +
	            string(idJugador) + "," +
				nivel + "," +
	            string_replace_all(pregunta, ",", ";") + "," +
	            string_replace_all(alternativas, ",", ";") + "," +
	            string_replace_all(respuestaJugador, ",", ";") + "," +
	            string(esCorrecta) + "," +
	            string(tiempoRespuesta) + "," +
				string(puntaje) + "\n";
	file_text_write_string(f, linea);
	file_text_close(f);
	
	var log_json = json_stringify({
		timestamp: timestamp,
        idJugador: idJugador,
		nivel: nivel,
        pregunta: pregunta,
        alternativas: alternativas,
        respuestaJugador: respuestaJugador,
        esCorrecta: esCorrecta,
        tiempoRespuesta: tiempoRespuesta,
        puntaje: puntaje
    });
	
	var url = "https://script.google.com/macros/s/AKfycbw4vXYgrQWQH-iGW38z0daj0aPFo_tH3TvAcvrV9ptQIet_cktxw6YWgs-lmUGztoTA8g/exec";
	
	http_post_string(url, log_json);
}