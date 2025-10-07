
// Si el objeto que crea esta instancia ya puso text[0] / text_x / text_y / text_width,
// no los sobreescribimos. Si no existen, ponemos valores por defecto.

// Esto es para definir el array que se usará en la escritura del texto de la pregunta
text[0] = "Hola mundo!";
text[1] = "a";

// Variables de control del texto
text_current = 0;
text_last = 0;
text_width = 810;
text_x = 230;
text_y = 140;
char_current = 1;
char_speed = 1;
font = fnt_PyR;
rmOrigem = 0;
line_sep = 70;