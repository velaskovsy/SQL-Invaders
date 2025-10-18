if (image_alpha < 1 && !global.respCntrl) image_alpha += 0.05;
if (!txtCntrl)
{
	var _inst = instance_create_layer(0, 0, "FX", obj_textoPregunta);
	_inst.text[0] = text[0];
	with(_inst)
		{
		text_last = 0;
		text_width = 1200;
		text_x = 400;
		text_y = 250;
		}
	txtCntrl = true;
}


alphaDestroy();