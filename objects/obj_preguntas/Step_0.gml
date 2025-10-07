// Cuando las balas lleguen a 0, aparece el quiz
	if (global.balas <= 0 && !quizActivo) {
	   crearPregunta();
	   pregunta_pausa();
	}


