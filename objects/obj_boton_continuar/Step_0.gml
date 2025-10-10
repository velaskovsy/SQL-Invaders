if (!txtCntrl)
{
	var _inst = instance_create_layer(x, y, "FX", obj_textoPregunta);
	_inst.text[0] = "Continuar";	
	with(_inst)
		{
		text_last = 0;
		text_width = 1000;
		text_x = x + 200;
		text_y = y + 55;
		font = fnt_feedback;
		}
	txtCntrl = true;
}