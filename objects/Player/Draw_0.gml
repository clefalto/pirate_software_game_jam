// PLAYER_DRAW

//draw_sprite(self.sprite_index, current_animation_frame, self.x, self.y);
// sprite is drawn in animator_draw();

//animator_draw(animator, x, y, rotation);

event_inherited();

//var _debug_color = self.is_grounded ? c_green : c_red;
//draw_rectangle_color(self.bbox_left, self.bbox_top, self.bbox_right - 1, self.bbox_bottom - 1, _debug_color, _debug_color, _debug_color, _debug_color, true);

for (var _i = bbox_left - 1; _i < bbox_right; _i++) {
	draw_point_color(_i, bbox_bottom, c_red);
}

for (var _i = bbox_left - 1; _i < bbox_right; _i++) {
	draw_point_color(_i, bbox_top, c_blue);
}

for (var _i = bbox_top - 1; _i < bbox_bottom; _i++) {
	draw_point_color(bbox_left, _i, c_green);
}

for (var _i = bbox_top - 1; _i < bbox_bottom; _i++) {
	draw_point_color(bbox_right, _i, c_yellow);
}