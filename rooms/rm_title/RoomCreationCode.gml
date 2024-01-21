// make main menu

// draw logo (when finished)

instance_create_depth(room_width/2 - (140/2), room_height/2 - 50, -1000, Menu, {
	"width": 140,
	"height": 50,
	"options": [ new MenuItem("start", fnt_m5x7, 90-3, 4, level_game_start), new MenuItem("quit", fnt_m5x7, 90 - 3, 4, game_end)] ,
	"centered": false,
	"text_centered": true,
	"title": "pixelbread spreadformer",
});

var _controls_text = "controls: arrow keys to move, hold z to charge jump, release z to execute jump. you can only move in the air.";
instance_create_depth(room_width/2, room_height/2, -1000, Text, {
	"str": _controls_text,
	"font": fnt_m5x7,
	"centered": true,
});