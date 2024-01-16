// update current frame
global.current_frame += 1;

// update dt, the lower time_scale is the longer there WOULD BE between frames, so the higher dt is
// global.dt is used in almost all things that move to control their speed and make it framerate independent
// altering dt using time_scale like this makes things that use dt move slower when time_scale is lower
// (i think)
global.dt = delta_time / 1000000;
//global.dt = delta_time / 1000000;

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