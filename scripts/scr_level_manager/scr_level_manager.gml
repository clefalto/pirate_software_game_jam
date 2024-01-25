current_level_ = -1;

// name: level number -> room that corresponds to it
// this is populated MANUALLY EWWW

first_level = 7;


level2room_ = array_create(0);
for (var _i = first_level; room_exists(_i); _i++) {
	array_push(level2room_, _i);
}

num_levels_ = array_length(level2room_);


// GLOBAL VARIABLES AAAAAAAAAAAAAAAAAAAAAAAGHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH
function level_get_current_level() {
	return global.current_level_;
}

function level_get_num_levels() {
	return global.num_levels_;
}

function level_restart() {
	if (!is_undefined(global.current_level_)) {
		stats_add_reset();
		level_switch(global.current_level_);
	}
	audio_stop_all();
}

function level_switch(_level_index) {
	if (_level_index == global.current_level_) {
		check_z_down_room_end();
		room_goto(global.level2room_[global.current_level_]);
		show_debug_message("level switched to " + string(_level_index));
		timer_enable_render();
		return true;
	}
	else if (_level_index >= global.num_levels_ || _level_index < 0) {
		return false;
	}
	else {
		check_z_down_room_end();
		global.current_level_ = _level_index;
		room_goto(global.level2room_[_level_index]);
		timer_enable_render();
		return true;
	}
}

function level_goto_next() {
	return level_switch(global.current_level_ + 1);
}

function level_goto_prev() {
	return level_switch(global.current_level_ - 1);
}

function level_add(_room_index) {
	// check to see if a level uses this room
	for (var _i = 0; _i < global.num_levels_; _i++) {
		if (struct_get(global.level2room, string(_i)) == _room_index) {
			return false;
		}
	}
	array_push(global.level2room_, _room_index);
	global.num_levels_++;
	return true;
}

function level_game_start() {
	global.current_level_ = 0;
	level_switch(global.current_level_);
	show_debug_message("game starting");
}

// call when starting the game again, puts you back at level 0. can effectively be replaced with return_to_title()
function restart_game() {
	global.current_level_ = 0;
	global.time_elapsed = 0;
	global.num_jumps = 0;
	global.num_resets = 0;
	level_switch(global.current_level_);
}

// call when returning to the title screen, resetting all global variables
function return_to_title() {
	global.current_level_ = -1;
	global.time_elapsed = 0;
	global.num_jumps = 0;
	global.num_resets = 0;
	room_goto(2);
}