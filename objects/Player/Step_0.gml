// PLAYER_STEP

// call every frame (TODO separate the player and the Character (bread) so that the Player object /sends/ data to the Character object)
function detect_input() {
	if (state == STATE.NORMAL) {
		if (input_enabled) {
			if (keyboard_check(vk_left) && keyboard_check(vk_right)) {
				x_input = 0;
			} else if (keyboard_check(vk_left)) {
				x_input = -1;
			} else if (keyboard_check(vk_right)) {
				x_input = 1;
			} else {
				x_input = 0;
			}
		
			jump_released_this_frame = false;
			
			// don't charge jump if jump is held down since last room
			if (true) { //!global.jump_down_since_last_room
				if (keyboard_check(ord("Z"))) {
					jump_held = true;
					time_held_jump += 1;
				}
			
				if (keyboard_check_pressed(ord("Z"))) {
					j_buffer = 4;
					frame_j_pressed = global.current_frame;
				}
	
				if (keyboard_check_released(ord("Z"))) {
					if (time_held_jump > 0 && time_held_jump < 50 && y_speed < 0) {
						ended_jump_early = true;
					}
					time_held_jump = 0;
					jump_held = false;
			
					jump_released_this_frame = true;
				}
			}
		}
	}
	else {
		x_input = 0;
		jump_held = false;
		time_held_jump = 0;
		j_buffer = -1;
		jump_released_this_frame = false;
	}
	
}

// call every frame
function update_flags() {
	// called when player just hits the ground
	if (!is_grounded && is_on_floor()) {
		// on_hit_ground(y_speed);
	}
	
	// called when player just leaves the ground
	if (is_grounded && !is_on_floor()) {
		on_leave_ground();
	}
	
	if (is_grounded) {
		ended_jump_early = false;
	} else {
		air_time_frames++;
	}
}

// call every frame the player is in the air
function calc_grav() {
	if (state == STATE.NORMAL) {
		if (ended_jump_early && y_speed < 0) {
			grav_scale = 1.5;
		}
		var _grav = grav * grav_scale;
	
		// framerate dependent B)
		y_speed = appr(y_speed * global.time_scale, fall_max, _grav * global.time_scale);
	}
}

// call every frame
function update_speed() {
	if (state == STATE.NORMAL) {
		var _target = 0;
		var _move_accel = move_accel;
		var _move_deccel = move_deccel;
		var _move_max = move_max;
		var _accel = _move_accel;
	
		var _target_direction = x_input; // if not on the ground, this is x_input
		if (is_grounded) _target_direction = 0;
	
		// calculating True x_speed
		if (abs(x_speed) > _move_max && _target_direction == sign(x_speed)) {
			_target = _move_max;
			if (!is_grounded) _accel = air_deccel;
			else _accel = _move_deccel;
		} else if (_target_direction != 0) {
			_target = _move_max;
		}
		// framerate dependent B)
		x_speed = appr(x_speed * global.time_scale, _target*_target_direction, _accel);
	
		// calculating desired_x_speed (what the speed Would be with the current x_input)
		_target = 0;
		_accel = _move_accel;
		if (abs(desired_x_speed) > _move_max && x_input == sign(desired_x_speed)) {
			_target = _move_max;
			if (!is_grounded) _accel = air_deccel;
			else _accel = _move_deccel;
		} else if (x_input != 0) {
			_target = _move_max;
		}
		desired_x_speed = appr(desired_x_speed * global.time_scale, _target*x_input, _accel);
	
		if (!is_grounded) {
			self.calc_grav();
			x_speed = desired_x_speed;
		} 
	
		//if (j_buffer > 0) {
		//	j_buffer -= 1;
		//	if (is_grounded) {
		//		self.jump();
		//	}
		//}
		if (is_grounded) {
			if (jump_held) {
				if (animator_get_animation(animator) != "squish") {
					animator_set_animation(animator, "squish");
					animator_disable_auto_update(animator);
				}
				if (!instance_exists(jump_meter)) {
					jump_meter = instance_create_depth(x, y, 0, JumpMeter);
				}
				charged_jump_force = clamp(charged_jump_force + 0.10, 0.0, charged_jump_max);
			}
	
			if (jump_released_this_frame) {
				jump2();
				if (instance_exists(jump_meter)) {
					instance_destroy(jump_meter);
				}
			}
		}
		
		if (bbox_bottom + 1 >= room_height) {
			kill_player();
		}
	}
}

// call every frame
// controls the player's animations 
function update_animation() {
	if (animator_get_animation(animator) == "air_spin") {
		// placeholder values subject to change
		var _min_playback_speed = 250; // ms
		var _max_playback_speed = 25; // ms
		
		var _current_playback_speed = lerp(_min_playback_speed, _max_playback_speed, abs(x_speed/move_max));
		
		var _playback_direction = sign(x_speed) < 0 ? -1 : 1;
		
		// manually do elapsed timing because the duration AND direction depends on the speed of the player.
		// i hate that i'm accessing the animator's private members from outside of it BUT THIS IS A SPECIAL CAAAASE so whatever
		
		animator.elapsed_time += (delta_time / 1000);
		if (animator.elapsed_time >= _current_playback_speed && abs(x_speed) > 0.01) {
			if (_playback_direction > 0) animator_increase_frame(animator);
			else animator_decrease_frame(animator);
			
			animator.elapsed_time = animator.elapsed_time mod _current_playback_speed;
			//animator.elapsed_time = 0;
		}
	
	}
	
	if (animator_get_animation(animator) == "squish") {
		// increase frame only when we're halfway done charging
		if (charged_jump_force/charged_jump_max >= 0.5 && (animator.current_frame != animation_get_last(animator.current_animation))) {
			animator_increase_frame(animator);
		}
	}
	
	animator_update(animator);
}

if (is_enabled) {
	self.update_flags();
	self.detect_input();
	self.update_speed();
	self.update_animation();
	
	if (spread_meter <= 0.0 && x_speed == 0 && is_grounded && y_speed == 0.0) {
		kill_player();
	}
	
	// move is called in event_inherited (above)
}

event_inherited();