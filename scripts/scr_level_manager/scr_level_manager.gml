current_level_ = 0;

// name: level number -> room that corresponds to it
// this is populated MANUALLY EWWW
level2room_ = [4, 5, 6, 7, 8, 9, 10];
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
		room_goto(global.level2room_[global.current_level_]);
	}
}

function level_switch(_level_index) {
	if (_level_index == global.current_level_) {
		level_restart();
		show_debug_message("level switched to " + string(_level_index));
		return true;
	}
	else if (_level_index >= global.num_levels_ || _level_index < 0) {
		return false;
	}
	else {
		global.current_level_ = _level_index;
		room_goto(global.level2room_[_level_index]);
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