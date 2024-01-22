draw_set_font(font);
var _str_width = string_width(str);
draw_sprite_stretched_ext(spr_text_background, 0, x + 4, y + 4, string_width(str) - 8 + 16, string_height(str) - 8 + 12, c_white, elapsed/duration - 0.4);
draw_sprite_stretched_ext(spr_text_border, 0, x, y, string_width(str) + 16, string_height(str) + 12, c_white, elapsed/duration);
draw_text_color(x + 8, y + 5, str, c_white, c_white, c_white, c_white, elapsed/duration);

if (delay > 0) {
	delay -= 1;
}
else if (elapsed > 0) {
	elapsed -= 1;
}