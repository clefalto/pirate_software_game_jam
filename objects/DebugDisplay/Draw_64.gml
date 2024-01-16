draw_set_font(fnt_m3x6);

if (global.player_exists) {
	draw_text(5, 6, animator_get_animation(global.player.animator));
	draw_text(5, 12, string(player.spread_meter));
	draw_text(5, 18, string(player.animator.current_frame));
}