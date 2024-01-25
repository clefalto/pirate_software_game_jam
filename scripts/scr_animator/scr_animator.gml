// animator

function animator_create(_animations = undefined) {
	show_debug_message("animator created");
	return {
		animations: _animations,
		current_animation: undefined,
		current_frame: 0,
		elapsed_time: 0,
		disable_auto_update: false,
		loop: false,
		on_animation_end: undefined,
		disable_set: false,
	}
}

// animation functions!
// call when you want to increase the frame of animation, wraps around the last frame to the first
function animator_increase_frame(_animator) {
	var _current_animation = _animator.current_animation;
	if (!is_undefined(_current_animation)) {
		if (_animator.current_frame >= animation_get_last(_current_animation)) {
			if (_animator.loop) {
				_animator.current_frame = animation_get_first(_current_animation);
			}
			else {
				_animator.disable_auto_update = true;
			}
			
			if (!is_undefined(_animator.on_animation_end)) {
				_animator.on_animation_end();
			}
		} 
		else {
			_animator.current_frame += 1;
		}
	}
}

// call when you want to decrease the frame of animation, wraps around the first frame to the last
// this is NOT automatically called by animator_update(_animator)
function animator_decrease_frame(_animator) {
	var _current_animation = _animator.current_animation;
	if (!is_undefined(_current_animation)) {
		if (_animator.current_frame - 1 <= animation_get_first(_current_animation)) {
			if (_animator.loop) {
				_animator.current_frame = animation_get_last(_current_animation);
			}
			else {
				_animator.disable_auto_update = true;
			}
			if (!is_undefined(_animator.on_animation_end)) {
				_animator.on_animation_end();
			}
		} 
		else {
			_animator.current_frame -= 1;
		}
	}
}

/// @param _animator: animator to update
/// @param _animation: string name of animation
/// @param _on_animation_end: callback function to call when this animation ends
/// note: enables auto update for this animator when the animation is changed
function animator_set_animation(_animator, _animation, _on_animation_end = undefined) {
	if (_animator.disable_set) return;
	if (!is_undefined(_animator.current_animation)) {
		if (animation_get_name(_animator.current_animation) != _animation) {
			if (!is_undefined(_animator.animations[$ _animation])) {
				_animator.current_animation = _animator.animations[$ _animation];
				_animator.elapsed_time = 0;
				_animator.disable_auto_update = false;
				_animator.on_animation_end = _on_animation_end;
				_animator.loop = !_animator.current_animation.one_shot
				_animator.current_frame = _animator.animations[$ _animation].first;
				
				return true;
			}
		}
	}
	else {
		if (!is_undefined(_animator.animations[$ _animation])) {
			_animator.current_animation = _animator.animations[$ _animation];
			_animator.elapsed_time = 0;
			_animator.disable_auto_update = false;
			_animator.on_animation_end = _on_animation_end;
			
			return true;
		}
	}
	return false;
}

function animator_get_animation(_animator) {
	if (is_undefined(_animator.current_animation)) {
		return "";
	}
	return animation_get_name(_animator.current_animation);
}

// call when you want to advance the current animation, meaning it will check if the amount of time elapsed is greater than the length of the current animation frame
// and will increase the frame if so
function animator_update(_animator) {
	if (is_undefined(_animator)) {
		return;
	}
	if (!is_undefined(_animator.current_animation)) {
		if (!_animator.disable_auto_update) {
			var _anim_length = animation_get_duration(_animator.current_animation);
			_animator.elapsed_time += (delta_time / 1000);
			if (_animator.elapsed_time >= _anim_length) {
				animator_increase_frame(_animator);
				_animator.elapsed_time = _animator.elapsed_time mod _anim_length;
			}
		}
	}
}

function animator_draw(_animator, _x, _y, _rotation) {
	if (is_undefined(_animator)) {
		return;
	}
	if (is_undefined(_animator.current_animation)) {
		return;
	}
	
	draw_sprite_ext(_animator.current_animation.sprite, _animator.current_frame, _x, _y, 1.0, 1.0, _rotation, c_white, 1.0);
}

function animator_disable_auto_update(_animator) {
	_animator.disable_auto_update = true;
}

function animator_enable_auto_update(_animator) {
	_animator.disable_auto_update = false;
}

function animator_disable_set(_animator) {
	_animator.disable_set = true;
}

function animator_enable_set(_animator) {
	_animator.disable_set = false;
}	