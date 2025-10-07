if (!txtCntrl)
{
	var _inst = instance_create_layer(x, y, "FX", obj_textoPregunta);
	_inst.text[0] = text[0];	
	with(_inst)
		{
		text_last = 0;
		text_width = 1000;
		text_x = x + 40;
		text_y = y + 30;
		font = fnt_respuesta;
		line_sep = 50;
		}
	txtCntrl = true;
}

