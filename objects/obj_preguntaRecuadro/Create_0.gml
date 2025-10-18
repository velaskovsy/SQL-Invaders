text[0] = "";
txtCntrl = false;
timer = room_speed * 2;
image_alpha = 0
depth = -1000;

alphaDestroy = function() {
	if (global.respCntrl = true)
	{
		timer = timer - 5;
		if (timer <= 0){
			//global.respCntrl = false;
			obj_preguntas.preguntaActiva = false;
			instance_destroy(self);
			instance_destroy(obj_textoPregunta, all);
		}
	}
}