// create this instance at x = -360, y = 0

draw_sprite(sprite_index, 0, x, y);


x += 10;

// todo: pause timer while wipe is on screen?

// call level restart
if (x >= -25 && !has_changed_level) {
	if (is_for_restart) {
		level_restart();
		has_changed_level = true;
	}
	else {
		level_goto_next();
		has_changed_level = true;
	}
}

if (x > 360) {
	instance_destroy();
}