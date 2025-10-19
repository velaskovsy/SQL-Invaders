global.vidas -= 1;

if (global.vidas <= 0){
	
	with (obj_controlador_usuarios) {
		actualizarPuntaje(); // subimos antes de ir al room de highscore
	}
	
	highscore_add("Test", score);
	room_goto(rm_highscores);
}