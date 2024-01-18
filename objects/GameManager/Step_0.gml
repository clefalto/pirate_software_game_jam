/// @desc GAME MANAGER STEP EVENT

// update current frame
global.current_frame += 1;

global.dt = delta_time / 1000000; // seconds

// pausing
if (keyboard_check_pressed(vk_escape)) {
	if (!global.is_paused) {
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