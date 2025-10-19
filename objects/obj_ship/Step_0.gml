move_wrap(true, true, sprite_width/2);

if (!instance_exists(obj_alien1)) {
	if (!instance_exists(obj_alien2)) {
		if (!instance_exists(obj_alien3)) {
			//Murieron todos los aliens
			
			with (obj_controlador_usuarios) {
				actualizarPuntaje(); // subimos el score actual
			}
			
			room_goto_next();
		} 
	}
}