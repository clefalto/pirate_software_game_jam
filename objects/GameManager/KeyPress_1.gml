if (global.is_in_debug_mode) {
	if (keyboard_check_pressed(ord("0"))) {
		room_goto(3);
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

if (global.current_level_ >= 0) {
	if (keyboard_check_pressed(ord("R"))) {
		timer_pause();
		if (global.player_exists) {
			global.player.kill_player();
		}
	}
	
	// full reset
	if (keyboard_check(ord("T"))) {
		return_to_title();
	}


	// pause on escape
	if (keyboard_check(vk_escape)) {
		if (global.is_paused) {
			unpause();
			instance_destroy(pause_menu);
		}
		else if (!global.is_paused) {
			pause();
			// spawn in pause menu
			pause_menu = instance_create_depth(x, y, -1000, Menu, {
				"width": 100,
				"height": 65,
				"line_height": 8,
				"text_centered": true,
				"options": [new MenuItem("resume", fnt_m5x7, 80, 8, unpause), new MenuItem("return to title", fnt_m5x7, 80, 8, return_to_title), new MenuItem("quit", fnt_m5x7, 80, 8, game_end)],
				"title": "paused",
			});
		}
	}
}