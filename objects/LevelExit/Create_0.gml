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