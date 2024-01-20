event_inherited();

animator = animator_create(global.level_exit_animations);
bounce_intermittence = 120 // frames


function anim_bounce() {
	animator_set_animation(animator, "bounce", anim_normal);
}

function anim_normal() {
	animator_set_animation(animator, "default");
}

self.anim_normal();
alarm[0] = bounce_intermittence;
self.enable();
self.enable_physics();

function anim_unite_complete() {
	// animator_disable_auto_update(animator); // keep frame locked at the unite one
	alarm[0] = -1;
	self.disable();
}