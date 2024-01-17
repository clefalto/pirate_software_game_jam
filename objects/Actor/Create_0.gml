/// @desc ACTOR CREATE EVENT

/* note:
	actors!
	inherited by all Things in the game which move!
	have an x_speed and a y_speed. set these in the inherited objects for the actor to move


*/

#region debug

x_min = 0;
x_max = 0;
y_max = 0;
y_min = 0;

#endregion

is_enabled = false;

x_speed = 0.0;
y_speed = 0.0;
x_remainder = 0.0;
y_remainder = 0.0;

rotation = 0.0;

animator = animator_create();

solids_layer = layer_tilemap_get_id("solids");

enable = function() {
	is_enabled = true;
}

disable = function() {
	is_enabled = false;
}

function set_solid_layer(_layer_name) {
	solids_layer = layer_tilemap_get_id(_layer_name);
}

/* ACTOR
*	base OBJECT for all ACTORS to use
*	actors are any object that moves and interacts with SOLIDS in some way
*/

/// @desc					moves an actor _amount pixels in the x direction, one pixel at a time. if a collision is detected w/ the actor's collision mask its x_velocity is set to 0 and the function exits
/// @param _collision_layer solids collision layer (usually this.solids_layer)
/// @param _amount			float amount of pixels to move along the x axis
function move_x(_collision_layer, _amount, _on_collide) {
	x_remainder += x_speed;
	var _x_move = round(x_remainder);
	if (_x_move != 0) {
		x_remainder -= _x_move;
		var _sign = sign(_x_move);
		// move one pixel at a time in the direction of movement
		while (_x_move != 0) {
			var _location_x = x + _sign;
			var _location_y = y;
			var _collision = collide_at(_collision_layer, _location_x, _location_y);
			if (!_collision) {
				x += _sign;
				_x_move -= _sign;
			}
			else {
				// collision. stop moving. you crazy bastard
				if (_on_collide) {
					_on_collide(_location_x, _location_y);
				}
				break;
			}
		}
	}
}

/// @desc					moves an actor _amount pixels in the y direction, one pixel at a time. if a collision is detected w/ the actor's collision mask its y_velocity is set to 0 and the function exits
/// @param _collision_layer solids collision layer (usually just this.solids_layer)
/// @param _amount			float amount of pixels to move along the y axis
function move_y(_collision_layer, _amount, _on_collide) {
	y_remainder += y_speed;
	var _y_move = round(y_remainder);
	if (_y_move != 0) {
		y_remainder -= _y_move;
		var _sign = sign(_y_move);
		// move one pixel at a time in the direction of movement
		while (_y_move != 0) {
			var _location_x = x;
			var _location_y = y + _sign;
			var _collision = collide_at(_collision_layer, _location_x, _location_y);
			if (!_collision) {
				y += _sign;
				_y_move -= _sign;
			}
			else {
				// collision. stop moving. you crazy bastard
				if _on_collide {
					_on_collide(_location_x, _location_y);
				}
				break;
			}
		}
	}
}

function move(_collision_layer, _x_amount, _on_x_collide, _y_amount, _on_y_collide) {
	move_x(_collision_layer, _x_amount, _on_x_collide);
	move_y(_collision_layer, _y_amount, _on_y_collide);
}

/// @desc					checks if the _object's collision mask intersects with the collision layer at position _x_pos, _y_pos
/// @param _collision_layer	solids collision layer (usually will be this.solids_layer)
/// @param _x_pos			x position to check
/// @param _y_pos			y position to check
// WARNING THIS IS VERY WASTEFUL FOR BIG BOUNDING BOXES! ONLY USE FOR SMALL ONES!
function collide_at(_collision_layer, _x_pos, _y_pos) {
	var _x_translate_amnt = _x_pos - x;
	var _y_translate_amnt = _y_pos - y;
	
	var _x_min = bbox_left + _x_translate_amnt;
	var _x_max = bbox_right-1 + _x_translate_amnt;
	var _y_min = bbox_top + _y_translate_amnt;
	var _y_max = bbox_bottom-1 + _y_translate_amnt;
	
	// check all sides of bbox
	// check top and bottom sides of rectangle
	for (var _i = _x_min; _i <= _x_max; _i++) {
		if (tilemap_get_at_pixel(_collision_layer, _i, _y_min) != 0) {
			return true;
		}
		if (tilemap_get_at_pixel(_collision_layer, _i, _y_max) != 0) {
			return true;
		}
	}
	
	// check left and right sides of rectangle
	for (var _i = _y_min; _i <= _y_max; _i++) {
		if (tilemap_get_at_pixel(_collision_layer, _x_min, _i) != 0) {
			return true;
		}
		if (tilemap_get_at_pixel(_collision_layer, _x_max, _i) != 0) {
			return true;
		}
	}
	
	return false;
} 

// callback functions for collisions, override in children
function on_x_collide(_x, _y) {}
function on_y_collide(_x, _y) {}