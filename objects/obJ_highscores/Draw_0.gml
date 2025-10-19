//draw_highscore(550, 450, 1550, 1450);

var _len = array_length(global.userArray);
for (var i = 0; i < _len; i++) {
    var _u = global.userArray[i];
    if (i == global.loginIndex) draw_set_color(c_lime);
    else draw_set_color(c_white);
    
    var _text = _u.username + " - " + string(_u.score);
    draw_text(550, 450 + (i * 80), _text);
}
draw_set_color(c_white);

// Evento Dibujo de obj_highscores_online
draw_text(550, 350, "Tabla de Puntajes");
draw_text(100, 1900, "Presiona enter para volver al menu principal")
