// Puntaje

draw_set_color(c_white);
draw_set_font(fnt_pixel); 

var margen = 16;
var texto = "Puntaje: " + string(score);

var x_pos = display_get_gui_width() - string_width(texto) - margen;
var y_pos = margen;

draw_text(x_pos, y_pos, texto);


