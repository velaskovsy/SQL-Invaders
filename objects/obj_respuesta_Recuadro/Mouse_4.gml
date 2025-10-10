// Inherit the parent event
event_inherited();

if (point_in_rectangle(mouse_x, mouse_y, x, y, x + sprite_width, y + sprite_height)) {
    obj_preguntas.verificarRespuesta(indice_respuesta);
}