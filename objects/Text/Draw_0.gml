
draw_set_font(font);
if (centered) {
	//draw_text_ext(x - width/2, y, str, string_height(str) - 4, width);
	draw_text_ext_color(x - width/2, y, str, string_height(str) - 4, width, color, color, color, color, 1.0);
}
else {
	//draw_text_ext(x, y, str, string_height(str) - 4, width);
	draw_text_ext_color(x, y, str, string_height(str) - 4, width, color, color, color, color, 1.0);
}