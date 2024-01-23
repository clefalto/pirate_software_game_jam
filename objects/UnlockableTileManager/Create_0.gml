// check where the spreadable tiles are on room creation

// array of spreadable tiles
initial_spreadable_tiles = [];
spreadable_tiles = [];
spreadable_tiles_x = [];
spreadable_tiles_y = [];
layer_spreadables = layer_get_id("spreadables");
tilemap_spreadables = layer_tilemap_get_id(layer_spreadables);
overlay = layer_tilemap_get_id("tile_overlay");

layer_outlines = layer_create(layer_get_depth(layer_spreadables) + 1, "outlines");

//surface_spreadables_mask = -1;
//surface_spreadables_tiles = -1;

//spreadables_layer = layer_get_id("spreadables");
//spreadables_tilemap = layer_tilemap_get_id(spreadables_layer);

// goofy nonfunctional shader shit, idk how this works

//upixelW = shader_get_uniform(sh_outline, "pixelW");
//upixelH = shader_get_uniform(sh_outline, "pixelH");

//texelW = texture_get_texel_width(sprite_get_texture(spr_bread_tiles, 0));
//texelH = texture_get_texel_height(sprite_get_texture(spr_bread_tiles, 0));

////uoutline_color = shader_get_uniform(sh_outline, "outline_color");
////shader_set_uniform_f(uoutline_color, 1.0, 1.0, 1.0, 1.0);

//shader_set_uniform_f(upixelW, texelW);
//shader_set_uniform_f(upixelH, texelH);

//if (layer_exists("spreadables")) {
//	layer_shader("spreadables", sh_outline);
//}

// iterate over every tile in the room
for (var _i = 0; _i < tilemap_get_width(tilemap_spreadables); _i++) {
	for (var _j = 0; _j < tilemap_get_height(tilemap_spreadables); _j++) {
		// add tile to the array if it's spreadable
		var _tiledata = tile_get_index(tilemap_get(tilemap_spreadables, _i, _j));
		if (_tiledata > 0) {
			array_push(spreadable_tiles, _tiledata);
			array_push(spreadable_tiles_x, _i);
			array_push(spreadable_tiles_y, _j);
			show_debug_message(spreadable_tiles);
		}
	}
}

if (array_length(spreadable_tiles) == 0) {
	global.all_tiles_spreaded = true;
	global.num_spreadable_tiles = 0;
} 
else {
	global.num_spreadable_tiles = array_length(spreadable_tiles);
	array_copy(initial_spreadable_tiles, 0, spreadable_tiles, 0, array_length(spreadable_tiles));
}

function check_spreadables_spreaded() {
	for (var _i = 0; _i < array_length(spreadable_tiles); _i++) {
		// show_debug_message("checking spreadables spreaded");
		var _tiledata = tilemap_get(overlay, array_get(spreadable_tiles_x, _i), array_get(spreadable_tiles_y, _i));
		if (_tiledata == 4) {
			array_delete(spreadable_tiles, _i, 1);
			array_delete(spreadable_tiles_x, _i, 1);
			array_delete(spreadable_tiles_y, _i, 1);
			global.num_spreadable_tiles = clamp(global.num_spreadable_tiles - 1, 0, 999999);
			
			if (global.num_spreadable_tiles == 0) {
				global.all_tiles_spreaded = true;
				audio_play_sound(snd_unlock_2, 10, false);
			}
		}
	}
}

function render_spreadable_outlines() {
	// render outline sprite behind all spreadable tiles
	for (var _i = 0; _i < array_length(spreadable_tiles); _i++) {
		var _tiledata = array_get(spreadable_tiles, _i);
		var _x_pixel = array_get(spreadable_tiles_x, _i) * tilemap_get_tile_width(tilemap_spreadables);
		var _y_pixel = array_get(spreadable_tiles_y, _i) * tilemap_get_tile_height(tilemap_spreadables);
		var _spr = -1;
		
		if (_tiledata == 33) {
			_spr = layer_sprite_create(layer_outlines, _x_pixel, _y_pixel, spr_spread_left_outline);
			//draw_sprite(spr_spread_left_outline, 0, _x_pixel, _y_pixel);
		}
		else if (_tiledata == 34) {
			_spr = layer_sprite_create(layer_outlines, _x_pixel, _y_pixel, spr_spread_mid_outline);
			//draw_sprite(spr_spread_mid_outline, 0, _x_pixel, _y_pixel);
		}
		else if (_tiledata == 35) {
			_spr = layer_sprite_create(layer_outlines, _x_pixel, _y_pixel, spr_spread_right_outline);
			//draw_sprite(spr_spread_right_outline, 0, _x_pixel, _y_pixel);
		}
		else if (_tiledata == 37) {
			_spr = layer_sprite_create(layer_outlines, _x_pixel, _y_pixel, spr_spread_single_outline);
			//draw_sprite(spr_spread_single_outline, 0, _x_pixel, _y_pixel);
		}
		
		//draw_sprite(_spr, 0, 
	}
}
