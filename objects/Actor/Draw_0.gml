/// @desc ACTOR DRAW EVENT

animator_draw(animator, x, y, rotation);

if (global.hitboxes_enabled) {
	draw_rectangle_color(bbox_left, bbox_top, bbox_right - 1, bbox_bottom - 1, c_red, c_red, c_red, c_red, true);
}