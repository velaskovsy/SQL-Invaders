
draw_set_colour(c_white);

switch (state){
	
	case DataStates.LOADING:
		draw_text(16, 16, "Cargando...");
		break;
		
	case DataStates.CHOOSE:
		draw_text(16, 16, "Presiona ENTER para escribir tu correo institucional");
		break;
		
	case DataStates.USERNAME:
		draw_text(16, 16, "Correo Institucional: " + username);
		draw_text(16, 48, "Presiona ENTER para seguir...");
		break;
		
	case DataStates.WELCOME:
		draw_text(16, 16, "¡Bienvenido a SQL Invaders!");
		draw_text(16, 48, "Este juego fue hecho con el propósito de enseñar consultas SQL con GROUP BY + HAVING");
		draw_text(16, 80, "El juego se compone de 3 niveles. Por cada respuesta correcta ganarás 100 puntos y 10 balas.");
		draw_text(16, 112, "Si te quedas sin municiones, aparecerán más preguntas para ayudarte.");
		draw_text(16, 144, "Para más información, presiona el botón de ayuda en el menú principal.");
		draw_text(16, 192, "Presiona ENTER para continuar...");
	break;
		
	case DataStates.ACCESS:
		var _user = array[login];
		draw_text(16, 16, _user.username);
		draw_text(16, 48, _user.score);
		draw_text(16, 80, "Presiona ECAPE para salir de tu sesión...");
	
		var _len = array_length(array);
		for (var i = 0; i<_len; i++){
			if (i == login) draw_set_color(c_lime);
			else draw_set_color(c_white)
		
			var _u = array[i];
			var _text = _u.username + " - " + string(_u.score);
			draw_text(16, 176 + (32 * i), _text);
		}
	break;
}