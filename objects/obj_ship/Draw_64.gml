// Para dibujar corazones
for (var i = 0; i < global.vidas; i++) {
    draw_sprite(Sprite19, 0, 16 + i*72, 16);
}

// Para dibujar el sprite de las balas 
draw_sprite(Sprite20, 0, 64, 16 + 64 + 8);

// Contador al lado derecho
draw_set_font(fnt_pixel)
draw_text(0 + sprite_width, 128, "x" + string(global.balas));