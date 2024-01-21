// check where the spreadable tiles are on room creation

// array of spreadable tiles
spreadable_tiles = [];
spreadable_tiles_x = [];
spreadable_tiles_y = [];
spreadables = layer_tilemap_get_id("spreadables");
overlay = layer_tilemap_get_id("tile_overlay");

// iterate over every tile in the room
for (var _i = 0; _i < tilemap_get_width(spreadables); _i++) {
	for (var _j = 0; _j < tilemap_get_height(spreadables); _j++) {
		// add tile to the array if it's spreadable
		var _tiledata = tile_get_index(tilemap_get(spreadables, _i, _j));
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
}

function check_spreadables_spreaded() {
	for (var _i = 0; _i < array_length(spreadable_tiles); _i++) {
		// show_debug_message("checking spreadables spreaded");
		if (tilemap_get(overlay, array_get(spreadable_tiles_x, _i), array_get(spreadable_tiles_y, _i)) > 0) {
			array_delete(spreadable_tiles, _i, 1);
			array_delete(spreadable_tiles_x, _i, 1);
			array_delete(spreadable_tiles_y, _i, 1);
			global.num_spreadable_tiles = clamp(global.num_spreadable_tiles - 1, 0, 999999);
			
			if (global.num_spreadable_tiles == 0) {
				global.all_tiles_spreaded = true;
			}
		}
	}
}