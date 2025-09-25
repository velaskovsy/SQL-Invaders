move_wrap(true, true, sprite_width/2);

if (!instance_exists(obj_alien1)) {
	if (!instance_exists(obj_alien2)) {
		if (!instance_exists(obj_alien3)) {
			//Murieron todos los aliens
			room_goto_next();
		}
	}
}