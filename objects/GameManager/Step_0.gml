/// @desc GAME MANAGER STEP EVENT

// update current frame
global.current_frame += 1;

global.dt = delta_time / 1000000; // seconds

// pausing
if (keyboard_check_pressed(vk_escape)) {
	if (!global.is_paused) {
		global.is_paused = true;
		if (global.player_exists) {
			global.player.input_enabled = false;
		}
		// pause every actor TODO pause everything that isn't an actor SUCH AS PARTICLES and animations
		for (var _i = 0; _i < instance_number(Actor); _i++) {
			var _obj = instance_find(Actor, _i);
		
			_obj.disable(); 
		}
	}
	
	else if (global.is_paused) {
		global.is_paused = false;
		if (global.player_exists) {
			global.player.input_enabled = true;
		}
		// enable actors
		for (var _i = 0; _i < instance_number(Actor); _i++) {
			var _obj = instance_find(Actor, _i);
		
			_obj.enable();
		}
	}
}

if (!global.is_paused) {
	part_manager_update_particles();
}