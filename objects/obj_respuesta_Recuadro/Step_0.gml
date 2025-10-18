/*if (!txtCntrl)
{
    var ancho_texto = 1200;
    var alto_max_cuadro = sprite_height * image_yscale; 

    //draw_set_font(fnt_respuesta);
    var alto_texto = string_height_ext(text[0], -1, ancho_texto);

    var fuente_final = fnt_respuesta;
    if (alto_texto > alto_max_cuadro - 40) {
        fuente_final = fnt_respuesta_p;
        draw_set_font(fnt_respuesta_p);
        alto_texto = string_height_ext(text[0], ancho_texto, -1); // recalcular con la nueva fuente
    }

    // Calcular posición vertical dinámica
    var offset_y;
    if (alto_texto < alto_max_cuadro - 60) {
        // Centrar verticalmente si el texto cabe bien
        offset_y = (alto_max_cuadro - alto_texto) / 2 - 10;
    } else {
        // Si es largo, dejarlo arriba
        offset_y = 30;
    }

    // Crear el texto
    var _inst = instance_create_layer(0, 0, "FX", obj_textoPregunta);
    _inst.text[0] = text[0];
    with (_inst)
    {
        text_last = 0;
        text_width = ancho_texto;
        text_x = other.x + 40;
        text_y = other.y + offset_y;
        font = fuente_final;
        line_sep = 50;
    }

    txtCntrl = true;
}

alphaDestroy();*/


if (!txtCntrl)
{
    var ancho_texto = 1100;
    var alto_max_cuadro = sprite_height * image_yscale; // altura real del recuadro

    draw_set_font(fnt_respuesta);
    var alto_texto = string_height_ext(text[0], -1, ancho_texto);

    var offset_y;
    if (alto_texto < alto_max_cuadro - 60) {
        // Centrar verticalmente si el texto es corto
        offset_y = (alto_max_cuadro - alto_texto) / 2 - 10;
    } else {
        // Dejar arriba si es largo
        offset_y = 30;
    }

    var _inst = instance_create_layer(0, 0, "FX", obj_textoPregunta);
    _inst.text[0] = text[0];
    with (_inst)
    {
        text_last = 0;
        text_width = ancho_texto;
        text_x = other.x + 40;
        text_y = other.y + offset_y;
        font = fnt_respuesta;
        line_sep = 50;
    }

    txtCntrl = true;
}

alphaDestroy();






