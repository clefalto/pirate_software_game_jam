event_inherited();

animator = animator_create(global.toaster_animations);
animator_set_animation(animator, "default");

absorbed_actor = undefined;
fling_force = 10.0;

// enable on creation
self.enable();

is_used = false;

function absorb_actor(_actor) {
	_actor.x = x;
	_actor.y = y;
	_actor.x_speed = 0;
	_actor.y_speed = 0;
	
	
	absorbed_actor = _actor;
	_actor.disable();
	
	show_debug_message("absorbed actor " + string(_actor));
	
	
	is_used = true;
	// wait 40 frames (play an animation or something idk)
	alarm[0] = 40;
}

function fling_actor(_actor) {
	_actor.y_speed = -fling_force;
	_actor.enable();
	
	show_debug_message("flung actor " + string(_actor));
	
	// animation?
	// ... perchance
}