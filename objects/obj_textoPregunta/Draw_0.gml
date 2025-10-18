// estilo
draw_set_font(font);
draw_set_color(text_color);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
depth = -1500;

// longitud total de la línea actual
var _line = text[text_current];
var _len = string_length(_line);

{
	char_current += char_speed;
}

var _str = string_copy(text[text_current], 1, char_current);
draw_text_ext(text_x, text_y, _str, line_sep, text_width);

