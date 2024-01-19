/// @desc GAME MANAGER STEP EVENT

// update current frame
global.current_frame += 1;

global.dt = delta_time / 1000000; // seconds

// pausing
if (keyboard_check_pressed(vk_escape)) {
	if (!global.is_paused) {
		// spawn in pause menu
		pause_menu = instance_create_depth(x, y, -1000, Menu, {
			"width": 50,
			"height": 75,
			"size_border": 4,
			"line_height": 8,
			"text_centered": true,
			"options": [new MenuItem("resume", fnt_m3x6, 25, 8, unpause), new MenuItem("options", fnt_m3x6, 25, 8), new MenuItem("quit", fnt_m3x6, 25, 8, game_end)],
			"title": "paused",
		});
		pause();
	}
	
	else if (global.is_paused) {
		global.is_paused = false;
		unpause();
	}
}

if (!global.is_paused) {
	part_manager_update_particles();
}