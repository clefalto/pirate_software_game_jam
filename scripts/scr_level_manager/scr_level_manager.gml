num_levels_ = 0;
current_level_ = undefined;

// name: level number -> room that corresponds to it
level2room_ = {};

function get_current_level() {
	return current_level_;
}

function get_num_levels() {
	return num_levels_;
}

function restart_level() {
	if (!is_undefined(current_level_)) {
		room_goto(level2room_[$ current_level_]);
	}
}

function switch_level(_level_index) {
	if (_level_index == current_level_) {
		restart_level();
		return true;
	}
	else if (_level_index >= num_levels_ || _level_index < 0) {
		return false;
	}
	else {
		current_level_ = _level_index;
		room_goto(level2room_[$ _level_index]);
		return true;
	}
}

function next_level() {
	return switch_level(current_level_ + 1);
}

function prev_level() {
	return switch_level(current_level_ - 1);
}

function add_level(_room_index) {
	// check to see if a level uses this room
	for (var _i = 0; _i < num_levels_; _i++) {
		if (struct_get(level2room, string(_i)) == _room_index) {
			return false;
		}
	}
	struct_set(level2room_, string(num_levels_), _room_index);
	num_levels_++;
	return true;
}