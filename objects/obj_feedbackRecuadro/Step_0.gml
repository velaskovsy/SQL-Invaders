//if (image_alpha < 1 && !global.respCntrl) image_alpha += 0.05;

// Esto es para crear el texto de manera dinamica dentro del cuadro
if (!txtCntrl)
{
	var _inst = instance_create_layer(0, 0, "FX", obj_textoPregunta);
	_inst.text[0] = text[0];
	with(_inst){
		text_last = 0;
		text_width = 1400;
		text_x = 340;
		text_y = 500;
		//font = fnt_feedback;
		//line_sep = 60;
		}
	var _inst2 = instance_create_layer(0, 0, "FX", obj_textoPregunta);
	if(obj_preguntas.respuesta_correcta){
		_inst2.text[0] = "Correcto";
		with(_inst2){
		text_color = c_lime;
		text_last = 0;
		text_width = 1400;
		text_x = 870;
		text_y = 320;
		
		//font = fnt_feedback;
		//line_sep = 60;
		}
	}else{
		_inst2.text[0] = "Incorrecto";
		with(_inst2){
		text_last = 0;
		text_width = 1400;
		text_x = 870;
		text_y = 320;
		text_color = c_red;
		//font = fnt_feedback;
		//line_sep = 60;
		}
	}
	txtCntrl = true;
}

/*if (alphadestroy) {
    alpha -= 0.05;
    if (alpha <= 0) {
        instance_destroy();
    }
}*/