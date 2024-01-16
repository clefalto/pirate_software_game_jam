// PLAYER_CREATE

event_inherited();

animator = animator_create(global.player_animations);

// create particle layer and system for player
part_layer = layer_create(0, "particles");
//part_system = part_system_create_layer(part_layer, false, ps_jam);

// when spread meter reaches zero, must restart the level!
// reduce spread meter by 
spread_meter = 100.0;
spread_reduction_factor = 15;

input_enabled = true;

enum STATE {
	NORMAL,
	DEAD,
}

#region internal physics Values (don't change these externally)

//x_speed = 0.0;
//y_speed = 0.0;
//x_remainder = 0.0;
//y_remainder = 0.0;

// what x_speed wouuld be if we weren't on the ground
desired_x_speed = 0.0;

x_input = 0;
is_grounded = false;
jump_held = false;
jump_pressed = false;
time_held_jump = 0;
j_buffer = -1;
frame_j_pressed = -1;

ended_jump_early = false;

grav_scale = 1.0;

air_time_frames = 0;

#endregion

#region physics Parameters (change these for different behavior)

fall_max = 4.0;
jump_force = 6.0;
move_speed = 0.75;
move_accel = 0.25;
move_deccel = 0.15;
move_max = 2.5;
grav = 0.25;

#endregion

#region various functions


#region CALLBACKS
// callback function, called when colliding (with solids) in the x direction
on_x_collide = function(_collision_side, _x, _y) { // @override
	if (_collision_side == SIDES.LEFT) {
		on_left_wall_collide();
	}
	else if (_collision_side == SIDES.RIGHT) {
		on_right_collide();
	}
}

// callback function, called when colliding (with solids) in the y direction
on_y_collide = function(_collision_side, _x, _y) { // @override
	if (_collision_side == SIDES.BOTTOM) {
		on_ground_collide();
	}
	else if (_collision_side == SIDES.TOP) {
		on_ceil_collide();
	}
}

on_left_wall_collide = function() {
	x_speed = 0.0;
	desired_x_speed = 0.0;
}

on_right_wall_collide = function() {
	x_speed = 0.0;
	desired_x_speed = 0.0;
}

on_ground_collide = function() {
	is_grounded = true;
	grav_scale = 1.0;
	// decrease spread meter proportional to y speed when landing
	reduce_spread_meter((y_speed/fall_max * (air_time_frames / game_get_speed(gamespeed_fps)) * (air_time_frames / game_get_speed(gamespeed_fps))) * spread_reduction_factor);
	y_speed = 0.0;
	
	ended_jump_early = false;
	
	air_time_frames = 0;
	
	// cosmetic effects!
	// create jam burst particles at landing spot!
	instance_create_depth(x, y, 0, JamParticles, {"part_layer": part_layer});
	// start playing grounded animation when hitting the ground
	animator_set_animation(animator, "grounded");
	//animation_play("grounded");
}

on_ceil_collide = function() {
	y_speed = 0.0;
	
	ended_jump_early = false;
}

on_hit_ground = function(_y_speed) {
	is_grounded = true;
	grav_scale = 1.0;
	// decrease spread meter proportional to y speed when landing
	reduce_spread_meter(_y_speed);
	air_time_frames = 0;
	
	// cosmetic effects!
	// create jam burst particles at landing spot!
	instance_create_depth(x, y, 0, JamParticles, {"part_layer": part_layer});
	// start playing grounded animation when hitting the ground
	animator_set_animation(animator, "grounded");
	//animation_play("grounded");
}

on_leave_ground = function() {
	is_grounded = false;
	animator_set_animation(animator, "initial_jump", on_anim_finish_air_initial_jump);
	//animation_play("initial_jump");
}

#endregion

// called to make player jump, this is also constantly called when the button is held down
jump = function() {
	y_speed = -jump_force;
}

// check if the player is on the floor, by checking 1 px below it on the far left and far right
is_on_floor = function() {
	for (var _i = bbox_left; _i < bbox_right; _i++) {
		if (tilemap_get_at_pixel(solids_layer, _i, bbox_bottom)) {
			return true;
		}
	}
	
	return false;
}

// decrease spread meter, called when hitting the ground. 
reduce_spread_meter = function(_amount) {
	// so that you don't die instantly when falling too fast
	if (_amount > 50.0) _amount = 50.0;
	spread_meter = clamp(spread_meter - _amount, 0.0, 100.0);
}

// restore spread meter to full
restore_spread_meter = function() {
	spread_meter = 100.0;
}



#endregion

#region animaTING


//current_animation = "grounded";
//current_animation_frame = animations[$ current_animation].first;
//anim_elapsed_time = 0;
//anim_ended_this_step = false;
//anim_disable_auto_update = false; 

on_anim_finish_air_initial_jump = function() {
	animator_set_animation(animator, "air_spin");
	animator_disable_auto_update(animator);
}

//// animation functions!
//// call when you want to increase the frame of animation, wraps around the last frame to the first
//animation_increase_frame = function() {
//	if (current_animation_frame + 1 >= animations[$ current_animation].last) {
//		current_animation_frame = animations[$ current_animation].first;
//		anim_ended_this_step = true;
//		if (animations[$ current_animation].one_shot) {
//			 on_animation_end(current_animation);
//			 anim_disable_auto_update = true;
//		}
//	} else {
//		current_animation_frame += 1;
//	}
//}

//// call when you want to decrease the frame of animation, wraps around the first frame to the last
//animation_decrease_frame = function() {
//	if (current_animation_frame - 1 <= animations[$ current_animation].first) {
//		current_animation_frame = animations[$ current_animation].last;
//		anim_ended_this_step = true;
//	} else {
//		current_animation_frame -= 1;
//	}
//}

//// play animation called _name
//animation_play = function(_name) {
//	if (current_animation != _name) {
//		if (animations[$ _name] != undefined) {
//			current_animation = _name;
//			anim_elapsed_time = 0;
//			anim_disable_auto_update = false;
//			return true;
//		}
//	}
//	return false;
//}

//// call when you want to advance the current animation, meaning it will check if the amount of time elapsed is greater than the length of the current animation frame
//// and will increase the frame if so
//animation_update = function() {
//	if (!anim_disable_auto_update) {
//		var _anim_length = animations[$ current_animation].length;
//		anim_elapsed_time += (delta_time / 1000);
//		if (anim_elapsed_time >= _anim_length) {
//			animation_increase_frame();
//			anim_elapsed_time = anim_elapsed_time mod _anim_length;
//		}
//	}
//}

#endregion
