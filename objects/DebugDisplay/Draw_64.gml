draw_set_font(fnt_m5x7);

if (global.debug_enabled) {
	if (global.player_exists) {
		draw_text(0, 0, "x_speed: " + string(player.x_speed));
		draw_text(0, 6, "y_speed: " + string(player.y_speed));
		draw_text(0, 12, "spread meter: " + string(player.spread_meter));
	}
}