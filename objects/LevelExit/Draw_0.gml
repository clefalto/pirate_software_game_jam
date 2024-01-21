event_inherited();

//draw_sprite(spr_bready_smally, 0, x - baby_radius/2 + baby_origin_x * baby_radius, (y - baby_radius/2 + baby_origin_y * baby_radius));
//baby_origin_x = sin(current_time/500);
//baby_origin_y = cos(current_time/500);
//draw_sprite(spr_bready_smally, 0, x - baby_radius/2 + baby_origin_x * baby_radius, (y - baby_radius/2 + baby_origin_y * baby_radius));

var _circle_subdiv_max = min(global.num_spreadable_tiles, 8);

for (var _i = 0; _i < _circle_subdiv_max; _i++) {
	baby_origin_x = sin(current_time/500 - (TAU/_circle_subdiv_max) * _i);
	baby_origin_y = cos(current_time/500 - (TAU/_circle_subdiv_max) * _i);
	draw_sprite(spr_bready_smally, baby_index, x - baby_radius/2 + baby_origin_x * baby_radius, (y - baby_radius/2 - 2 + baby_origin_y * baby_radius));
}

baby_elapsed_time += (delta_time/1000);
if (baby_elapsed_time >= 100.0) {
	baby_index += 1;
	if (baby_index > 7) {
		baby_index = 0;
	}
	baby_elapsed_time = baby_elapsed_time mod 100.0;
}