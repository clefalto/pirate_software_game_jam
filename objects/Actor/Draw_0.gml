/// @desc ACTOR DRAW EVENT

animator_draw(animator, x, y, rotation);
//var _x_min = bbox_left + _x_translate_amnt;
//	var _x_max = bbox_right-1 + _x_translate_amnt;
//	var _y_min = bbox_bottom-1 + _y_translate_amnt;
//	var _y_max = bbox_top + _y_translate_amnt;
draw_rectangle_color(x_min, y_min, x_max, y_max, c_green, c_green, c_green, c_green, true);
draw_rectangle_color(bbox_left, bbox_top, bbox_right - 1, bbox_bottom - 1, c_white, c_white, c_white, c_white, true);