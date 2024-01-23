if (global.is_in_debug_mode) {
	if (keyboard_check_pressed(ord("0"))) {
		room_goto(3);
	}

	if (keyboard_check_pressed(ord("R"))) {
		level_restart();
	}

	if (keyboard_check_pressed(ord("E"))) {
		level_goto_next();
	}

	if (keyboard_check_pressed(ord("Q"))) {
		level_goto_prev();
	}

	if (keyboard_check_pressed(ord("H"))) {
		global.debug_enabled = !global.debug_enabled;
	}
}