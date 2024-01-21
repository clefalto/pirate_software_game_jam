event_inherited();

animator = animator_create(global.level_exit_animations);
bounce_intermittence = 120 // frames

baby_index = 0;
baby_radius = 15; // px
baby_elapsed_time = 0.0;

baby_origin_x = 1;
baby_origin_y = 0;

baby_sprite = spr_bready_smally;


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