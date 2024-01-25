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

// muting audio
if (keyboard_check(ord("M"))) {
	if (audio_get_master_gain(0) == 0.0) {
		audio_master_gain(1.0);
	}
	else if (audio_get_master_gain(0) == 1.0) {
		audio_master_gain(0.0);
	}
}

// pause on escape
if (keyboard_check(vk_escape)) {
	if (global.is_paused) {
		unpause();
	}
	else if (!global.is_paused) {
		pause();
	}
}