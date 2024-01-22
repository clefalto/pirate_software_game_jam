event_inherited();

animator = animator_create(global.level_exit_animations);
bounce_intermittence = 120 // frames

baby_index = 0;
baby_radius = 15; // px
baby_elapsed_time = 0.0;

baby_origin_x = 1;
baby_origin_y = 0;

baby_sprite = spr_bready_smally;

sound_played = false;

just_collided_with_player = false;
collided_with_player_last_frame = false;


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

function is_colliding_with_player() {
	if (point_in_rectangle(bbox_left, bbox_top, global.player.bbox_left, global.player.bbox_top, global.player.bbox_right, global.player.bbox_bottom)) {
		return true;
	}
	else if (point_in_rectangle(bbox_right, bbox_top, global.player.bbox_left, global.player.bbox_top, global.player.bbox_right, global.player.bbox_bottom)) {
		return true;
	}
	else if (point_in_rectangle(bbox_left, bbox_bottom, global.player.bbox_left, global.player.bbox_top, global.player.bbox_right, global.player.bbox_bottom)) {
		return true;
	}
	else if (point_in_rectangle(bbox_right, bbox_bottom, global.player.bbox_left, global.player.bbox_top, global.player.bbox_right, global.player.bbox_bottom)) {
		return true;
	}
	else return false;
}

function check_just_collide_with_player() {
	//if (!just_collided_with_player) {
	//	if (is_colliding_with_player()) {
	//		just_collided_with_player = true;
	//		return true;
	//	}
	//}
	//else if (is_colliding_with_player()) {
	//	just_collided_with_player = false;
	//	return false;
	//}
	
	var _is_colliding = is_colliding_with_player();
	
	if (collided_with_player_last_frame && _is_colliding) {
		return false;
	}
	else if (!collided_with_player_last_frame && _is_colliding) {
		collided_with_player_last_frame = true;
		return true;
	}
	else if (!_is_colliding) {
		collided_with_player_last_frame = false;
		return false;
	}
}