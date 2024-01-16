time_scale = 1.0;
dt = delta_time / 1000000;
previous_time_scale = global.time_scale;
current_frame = 0;

function set_time_scale(_new_value) {
	if (_new_value < 0) return;
	global.time_scale = _new_value;
}

function pause_game() {
	global.previous_time_scale = global.time_scale;
	global.time_scale = 0;
}

function unpause_game() {
	global.time_scale = global.previous_time_scale;
}