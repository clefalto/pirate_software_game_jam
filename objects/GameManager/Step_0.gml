/// @desc GAME MANAGER STEP EVENT

// update current frame
global.current_frame += 1;

global.dt = delta_time / 1000000; // seconds

if (!global.is_paused) {
	part_manager_update_particles();
}

// continue checking if the player releases z since the last room 
if (global.jump_down_since_last_room) {
	check_z_down_room_start();
}

// show_debug_message(string(global.jump_down_since_last_room));

timer_update();