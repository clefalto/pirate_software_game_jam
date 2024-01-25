// PLAYER_CREATE


input_enabled = false;
//alarm[2] = 20;

event_inherited();
enable_physics(); // enabled physics on create

animator = animator_create(global.player_animations);

// create particle layer and system for player
part_layer = layer_create(0, "particles");
tile_overlay = layer_tilemap_get_id("tile_overlay");
//part_system = part_system_create_layer(part_layer, false, ps_jam);

// when spread meter reaches zero, must restart the level!
// reduce spread meter by 
spread_meter = 100.0;
spread_reduction_factor = 4.5;

enum STATE {
	NORMAL,
	DEAD,
	DISABLED
}

state = STATE.NORMAL;
visible = true;

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

jump_released_this_frame = false;
charged_jump_force = 0.0;
charged_jump_max = 6.0;
jump_meter = undefined;

grav_scale = 1.0;

air_time_frames = 0;

#endregion

#region physics Parameters (change these for different behavior)

fall_max = 4.0;
jump_force = 6.0;
move_speed = 0.75;
move_accel = 0.25;
move_deccel = 0.15;
air_deccel = 0.05;
move_max = 2.5;
grav = 0.25;

#endregion

#region various functions


#region CALLBACKS
// callback function, called when colliding (with solids) in the x direction
on_x_collide = function(_x, _y) { // @override
	if (check_collide_left_wall()) {
		on_left_wall_collide();
		show_debug_message("collided with left wall");
	}
	if (check_collide_right_wall()) {
		on_right_wall_collide();
		show_debug_message("collided with right wall");
	}
}

// callback function, called when colliding (with solids) in the y direction
on_y_collide = function(_x, _y) { // @override
	if (check_collide_ground()) {
		on_ground_collide();
		show_debug_message("collided with ground");
	}
	if (check_collide_ceil()) {
		on_ceil_collide();
		show_debug_message("collided with ceiling");
	}
}

function check_collide_ground() {
	for (var _i = bbox_left; _i < bbox_right; _i++) {
		if (tilemap_get_at_pixel(solids_layer, _i, bbox_bottom) != 0 || tilemap_get_at_pixel(spreadables_layer, _i, bbox_bottom) != 0) {
			return true;
		}
	}
	return false;
}

function check_collide_ceil() {
	for (var _i = bbox_left; _i < bbox_right; _i++) {
		if (tilemap_get_at_pixel(solids_layer, _i, bbox_top - 1) != 0 || tilemap_get_at_pixel(spreadables_layer, _i, bbox_top - 1) != 0) {
			return true;
		}
	}
	return false;
}

function check_collide_left_wall() {
	for (var _i = bbox_top; _i < bbox_bottom; _i++) {
		if (tilemap_get_at_pixel(solids_layer, bbox_left - 1, _i) != 0 || tilemap_get_at_pixel(spreadables_layer, bbox_left - 1, _i) != 0) {
			return true;
		}
	}
	return false;
}

function check_collide_right_wall() {
	for (var _i = bbox_top; _i < bbox_bottom; _i++) {
		if (tilemap_get_at_pixel(solids_layer, bbox_right, _i) != 0 || tilemap_get_at_pixel(spreadables_layer, bbox_right, _i) != 0) {
			return true;
		}
	}
	return false;
}

on_left_wall_collide = function() {
	x_speed = 0.0;
	desired_x_speed = 0.0;

	//part_manager_create_particles(ps_jam_right, x, y, part_layer);
}

on_right_wall_collide = function() {
	x_speed = 0.0;
	desired_x_speed = 0.0;

	//part_manager_create_particles(ps_jam_left, x, y, part_layer);
}

on_ground_collide = function() {
	is_grounded = true;
	grav_scale = 1.0;
	// decrease spread meter proportional to y speed when landing
	var _seconds_in_air = air_time_frames/game_get_speed(gamespeed_fps);
	var _percent_fall_speed = y_speed/fall_max;
	
	y_speed = 0.0;
	
	ended_jump_early = false;
	
	air_time_frames = 0;
	
	// cosmetic effects!
	// create jam burst particles at landing spot!
	if (global.current_frame >= 3) {
		part_manager_create_particles(ps_jam_up, x, y, part_layer);
		
		#region create splatter tiles
		// create jammed tiles at landing location, 3 tile width for middle (5 tile width in total)
		
		// get landing tile
		var _tile_x = tilemap_get_cell_x_at_pixel(tile_overlay, x, bbox_bottom);
		var _tile_y = tilemap_get_cell_y_at_pixel(tile_overlay, x, bbox_bottom);
		
		//var _tile_x_spreadables = tilemap_get_cell_x_at_pixel(spreadables_layer, x, bbox_bottom);
		//var _tile_y_spreadables = tilemap_get_cell_y_at_pixel(spreadables_layer, x, bbox_bottom);
		
		// bounds
		var _tile_far_left = clamp(_tile_x - 1, 0, tilemap_get_width(tile_overlay));
		var _tile_far_right = clamp(_tile_x + 1, 0, tilemap_get_width(tile_overlay));
		
		var _tiledata_center = tilemap_get(solids_layer, _tile_x, _tile_y);
		var _tiledata_left = tilemap_get(solids_layer, _tile_far_left, _tile_y);
		var _tiledata_right = tilemap_get(solids_layer, _tile_far_right, _tile_y);
		
		
		
		// check if the tile on the far left is not solid or oob,
		// if so, set the left tile to the tile we landed on
		
		
		
		if (_tiledata_center <= 0) {
			if (_tiledata_left <= 0) {
				_tile_x = _tile_far_right;
			}
			else if (_tiledata_right <= 0) {
				_tile_x = _tile_far_left;
			}
		}
		
		if (_tiledata_left <= 0) {
			_tile_far_left = _tile_x;
		}
		
		// same as above for tile on far right
		
		if (_tiledata_right <= 0) {
			_tile_far_right = _tile_x;
		}
		
		var _tiledata_center_above = tilemap_get(solids_layer, _tile_x, _tile_y - 1);
		var _tiledata_left_above = tilemap_get(solids_layer, _tile_far_left, _tile_y - 1);
		var _tiledata_right_above = tilemap_get(solids_layer, _tile_far_right, _tile_y - 1);
		
		if (_tiledata_left_above > 0) {
			_tile_far_left = _tile_x;
		}
		
		if (_tiledata_right_above > 0) {
			_tile_far_right = _tile_x;
		}
		
		
	
		// tiledata indices guide:
		/*
			0	1	2
			3	4	5
			6	7	8
		*/
	
		// set far right and far left tiles
		
	
		// tile above, if there is a tile above don't place splatter bc that wouldn't make sense
		var _solids_tiledata_above = tilemap_get(solids_layer, _tile_far_left - 1, _tile_y - 1);
	
		// far far left tile (little bit that goes over to the next tile)
		var _tiledata = tilemap_get(tile_overlay, _tile_far_left - 1, _tile_y);
		var _solids_tiledata = tilemap_get(solids_layer, _tile_far_left - 1, _tile_y);
		if (_solids_tiledata >= 0 && _tiledata == 0 && _solids_tiledata_above == 0) {
			var _data = tile_set_index(_tiledata, 3);
			tilemap_set(tile_overlay, _data, _tile_far_left - 1, _tile_y);
		}
		
		
		_solids_tiledata_above = tilemap_get(solids_layer, _tile_far_right + 1, _tile_y - 1);
	
		// far far right tile
		_tiledata = tilemap_get(tile_overlay, _tile_far_right + 1, _tile_y);
		_solids_tiledata = tilemap_get(solids_layer, _tile_far_right + 1, _tile_y);
		if (_solids_tiledata >= 0 && _tiledata == 0 && _solids_tiledata_above == 0) {
			var _data = tile_set_index(_tiledata, 5);
			tilemap_set(tile_overlay, _data, _tile_far_right + 1, _tile_y);
		}
	
		// iterate through all three tiles we care about
		for (var _i = _tile_far_left; _i <= _tile_far_right; _i++) {
			// set middle tile
		
			// tile above 
			_solids_tiledata_above = tilemap_get(solids_layer, _i, _tile_y - 1);
		
			// if there's a (nonzero) tile above this one, it doesn't make sense for the jam to jam
			if (_solids_tiledata_above == 0) {
				_solids_tiledata = tilemap_get(solids_layer, _i, _tile_y);
				_tiledata = tilemap_get(tile_overlay, _i, _tile_y);
				if (_solids_tiledata > 0 && _tiledata >= 0) {
					var _data = tile_set_index(_tiledata, 4);
					tilemap_set(tile_overlay, _data, _i, _tile_y);
				}
		
				// set top tile
				_tiledata = tilemap_get(tile_overlay, _i, _tile_y - 1);
				if (_solids_tiledata > 0 && _solids_tiledata_above == 0 && _tiledata >= 0) {
					var _data = tile_set_index(_tiledata, 1);
					tilemap_set(tile_overlay, _data, _i, _tile_y - 1);
				}
			}
		}
		#endregion
	}
	
	// check if jump meter exists and you're not on the ground (means you were holding jump and slid off)
	if (instance_exists(jump_meter)) {
		instance_destroy(jump_meter);
	}
	
	// cosmetic effects
	// start playing grounded animation when hitting the ground
	animator_set_animation(animator, "default");
	if (global.current_frame >= 3) {
		// play landing nouise
		if (global.silly) {
			audio_play_sound(snd_SPLAT, 10, false, 0.5, 0.1, 1.2);
		}
		else {
			audio_play_sound(snd_land_2, 10, false, 0.8, 0, 1.2);
		}
	}		
}

on_ceil_collide = function() {
	y_speed = 0.0;
	
	ended_jump_early = false;
}

on_hit_ground = function(_y_speed) {
	is_grounded = true;
	grav_scale = 1.0;
	// decrease spread meter proportional to y speed when landing
	// reduce_spread_meter(_y_speed);
	air_time_frames = 0;
	
	// cosmetic effects!
	// create jam burst particles at landing spot!
	//instance_create_depth(x, y, 0, JamParticles, {"part_layer": part_layer});
	part_manager_create_particles(ps_jam_up, x, y, part_layer);
	// start playing grounded animation when hitting the ground
	animator_set_animation(animator, "default");
}

on_leave_ground = function() {
	is_grounded = false;
	animator_set_animation(animator, "initial_jump", on_anim_finish_air_initial_jump);
}

#endregion

function kill_player() {
	if (state != STATE.DEAD) {
		state = STATE.DEAD;
		disable_physics();
		on_player_die();
	}
}

function on_player_die(_message = "you're toast") {
	// don't repeatedly kill the player
	// play die animation for player
	audio_stop_all();
	audio_play_sound(snd_death, 10, false);
	animator_set_animation(animator, "die");
	animator_disable_set(animator);
	var _gm = instance_find(GameManager, 0)
	_gm.on_player_die();
}

//// called to make player jump, this is also constantly called when the button is held down
//jump = function() {
//	y_speed = -jump_force;
//}

function jump2() {
	y_speed = -charged_jump_force;
	x_speed += charged_jump_force * x_input * 0.2;
	desired_x_speed += charged_jump_force * x_input * 0.2;
	reduce_spread_meter(charged_jump_force * spread_reduction_factor);
	
	audio_play_sound(snd_jump, 10, false, 1, 0, 0.75 + charged_jump_force/charged_jump_max);
	stats_add_jump();
	
	charged_jump_force = 0.0;
	
	
}

// check if the player is on the floor, by checking 1 px below it on the far left and far right
is_on_floor = function() {
	for (var _i = bbox_left; _i < bbox_right; _i++) {
		if (tilemap_get_at_pixel(solids_layer, _i, bbox_bottom) != 0 || tilemap_get_at_pixel(spreadables_layer, _i, bbox_bottom) != 0) {
			return true;
		}
	}
	
	return false;
}

// decrease spread meter, called when hitting the ground. 
reduce_spread_meter = function(_amount) {
	// so that you don't die instantly when falling too fast
	if (_amount > 20.0) _amount = 20.0;
	spread_meter = clamp(spread_meter - _amount, 0.0, 100.0);
}

// restore spread meter to full
restore_spread_meter = function() {
	spread_meter = 100.0;
}

#endregion

// animation callbacks
on_anim_finish_air_initial_jump = function() {
	animator_set_animation(animator, "air_spin");
	animator_disable_auto_update(animator);
}

// disable gravity for the player for _length frames
function disable_gravity(_length = 60) {
	grav_scale = 0.0;
	alarm[3] = _length;
}

//function enable_input() {
//	input_enabled = true;
//	// animator_enable_set(animator);
//}

// actual creation Code Steps
enable();

audio_play_sound(snd_respawn, 10, false);
animator_set_animation(animator, "spawn", function() { input_enabled = true; animator_enable_set(animator)} );
animator_disable_set(animator);
//enable();