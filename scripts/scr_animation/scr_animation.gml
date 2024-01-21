#macro TAU pi*2

function animation_create(_name, _sprite, _frame_duration, _first, _last, _one_shot = false) {
	return {
		name_: _name,
		sprite: _sprite,
		first: _first,
		last: _last,
		frame_duration: _frame_duration,
		one_shot: _one_shot,
	}
}

function animation_get_length(_animation) {
	return _animation.last - _animation.first;
}

function animation_get_duration(_animation) {
	return _animation.frame_duration;
}

//function animation_get_frame(_animation, _time) {
//	return floor(_time / _animation.frame_duration_);
//}

function animation_get_first(_animation) {
	return _animation.first;
}

function animation_get_last(_animation) {
	return _animation.last;
}

function animation_get_name(_animation) {
	return _animation.name_;
}