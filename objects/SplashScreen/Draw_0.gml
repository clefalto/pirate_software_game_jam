draw_sprite_ext(spr_splash_downscaled, 0, x, y, 1, 1, 0, c_white, elapsed/duration);
if (delay > 0) {
	delay--;
}
else {
	elapsed--;
	if (elapsed <= 0) {
		instance_destroy(self);
	}
}