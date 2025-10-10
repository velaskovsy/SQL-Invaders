text[0] = "";
txtCntrl = false;
timer = room_speed * 2;
indice_respuesta = 0;
autoDestroy = false;


alphaDestroy = function()
{
	if (global.respCntrl = true) autoDestroy = true;
	if (autoDestroy)
	{
		timer = timer - 5;
		if (timer <= 0) instance_destroy(self);
	}
}