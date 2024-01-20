if (global.player_exists) {
	// draw Jam Meter (previously known as Spread Meter)
	var _player = global.player;
	var _x = 10;
	var _y = 10;
	
	var _width = 100;
	var _height = 16;
	
	draw_sprite_stretched_ext(spr_jam_meter_bg, 0, _x + 2, _y + 2, _width - 4, _height - 3, c_white, 0.75);
	draw_sprite_stretched(spr_jam_meter_inside, 0, _x + 2, _y + 2, _player.spread_meter - 4, _height - 3);
	draw_sprite_stretched(spr_jam_meter_border, 0, _x, _y, 100, _height);
}