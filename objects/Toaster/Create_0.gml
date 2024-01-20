event_inherited();

self.depth = -1;

animator = animator_create(global.toaster_animations);
animator_set_animation(animator, "default");

absorbed_actor = undefined;
fling_force = 7.0;

// enable on creation
self.enable();

is_used = false;

// also the face direction of the sprite!
//fling_dir_x;
//fling_dir_y;



function absorb_actor(_actor) {
	_actor.x = x;
	_actor.y = y;
	_actor.x_speed = 0;
	_actor.y_speed = 0;
	
	absorbed_actor = _actor
	_actor.visible = false;
	_actor.disable();
	
	show_debug_message("absorbed actor " + string(_actor));
	
	
	is_used = true;
	// wait 40 frames (play an animation or something idk)
	animator_set_animation(animator, "absorb");
	alarm[0] = 40;
}

function fling_actor(_actor) {
	// warning this line of code makes it so that toaster can only fling player, other actors will crash the game
	// i would fix this and refactor player to make it so that x_speed isn't set to desired_x_speed if it's not grounded but IDC ENOUGH
	var _hyp = sqrt(sqr(fling_dir_x) + sqr(fling_dir_y));
	var _normalized_x = fling_dir_x / _hyp;
	var _normalized_y = fling_dir_y / _hyp;
	
	_actor.desired_x_speed = _normalized_x * fling_force;
	_actor.x_speed = _normalized_x * fling_force;
	_actor.y_speed = _normalized_y * fling_force;
	
	if (fling_dir_x != 0) {
		_actor.disable_gravity(10); // disable player's gravity for 40 frames
	}
	
	_actor.enable();
	_actor.visible = true;
	
	show_debug_message("flung actor " + string(_actor));
	
	// animation?
	// ... perchance
	animator_set_animation(animator, "fling", finish_fling);
}

function finish_fling() {
	animator_set_animation(animator, "used")
}

function adjust_rotation(_new_x_vector, _new_y_vector) {
	var _hyp = sqrt(sqr(_new_x_vector) + sqr(_new_y_vector));
	
	_angle = radtodeg(arcsin(-_new_y_vector/_hyp));
	
	
	rotation = _angle - 90; // up is right
}

adjust_rotation(fling_dir_x, fling_dir_y);