jam_meter_bg = spr_jam_meter_bg;
jam_meter_inside = spr_jam_meter_inside;
jam_meter_border = spr_jam_meter_border;

width = 30; // px
height = 8; // px

player = global.player_exists ? global.player : undefined;

player_x_offset = width/2;
player_y_offset = 20; 

function render_meter() {
	x = player.x - player_x_offset;
	y = player.y - player_y_offset;
	draw_sprite_stretched_ext(jam_meter_bg, 0, x + 2, y + 2, width - 4, 5, c_white, 0.75);
	draw_sprite_stretched(jam_meter_inside, 0, x + 2, y + 2, player.charged_jump_force/player.charged_jump_max * width - 4, 5);
	draw_sprite_stretched(jam_meter_border, 0, x, y, width, 8);
}