//draw_highscore(550, 450, 1550, 1450);

var _len = array_length(global.userArray);
for (var i = 0; i < _len; i++) {
    var _u = global.userArray[i];
    if (i == global.loginIndex) draw_set_color(c_lime);
    else draw_set_color(c_white);
    
    var _text = _u.username + " - " + string(_u.score);
    draw_text(550, 450 + (i * 32), _text);
}
draw_set_color(c_white);
