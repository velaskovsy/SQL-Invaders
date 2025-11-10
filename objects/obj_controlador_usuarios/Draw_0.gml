draw_set_font(fnt_PyR);
draw_set_colour(c_white);

switch (state){
	
	case DataStates.LOADING:
		draw_text(16, 16, "Cargando...");
		break;
		
	case DataStates.CHOOSE:
		draw_text(16, 400, "¡Bienvenido a SQL Invaders!");
		draw_text(16, 600, "Presiona ENTER para escribir tu correo solo si estás\nregistrado");
		draw_text(16, 800, "Presiona SHIFT para escribir tu correo si es que no\nestás registrado")
		break;
		
	case DataStates.USERNAME:
		draw_text(16, 400, "¡Bienvenido a SQL Invaders!");
		draw_text(16, 600, "Correo: " + username);
		draw_text(16, 800, "Presiona ENTER para seguir...");
		break;
		
	case DataStates.WELCOME:
		draw_text(16, 400, "¡Bienvenido a SQL Invaders!");
		draw_text(16, 600, "Este juego fue hecho con el propósito de enseñar consultas SQL\ncon GROUP BY + HAVING");
		draw_text(16, 800, "El juego se compone de 3 niveles. Por cada respuesta correcta\nganarás 100 puntos y 8 balas.");
		draw_text(16, 1000, "Si te quedas sin municiones, aparecerán más preguntas para\nayudarte.");
		draw_text(16, 1200, "Para más información, presiona el botón de ayuda en el menú\nprincipal.");
		draw_text(16, 1400, "Presiona ENTER para continuar...");
		
		break;
		
	case DataStates.ACCESS:
		var _user = array[login];
		draw_text(16, 16, _user.username);
		draw_text(16, 48, _user.score);
		draw_text(16, 80, "Presiona ESCAPE para salir de tu sesión...");
	
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