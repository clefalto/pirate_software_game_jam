// make main menu

// draw logo (when finished)

timer_pause();
timer_disable_render();

start_game = function() {
	level_game_start();
	timer_unpause();
	timer_enable_render();
}

// title
//instance_create_depth(room_width/2, room_height/2 - 70, -1000, Text, {
//	"str": "LEAVEN",
//	"font": fnt_m5x7,
//	"centered": true,
//});

draw_sprite(spr_logo, 0, room_width/2, room_height/2 - 10);

instance_create_depth(room_width/2 - (50/2), room_height/2 - 25, -1000, Menu, {
	"width": 50,
	"height": 30,
	"options": [ new MenuItem("start", fnt_m5x7, 90-3, 4, start_game), new MenuItem("quit", fnt_m5x7, 90 - 3, 4, game_end)] ,
	"centered": false,
	"text_centered": true,
	"title": "",
});

var _controls_text = "controls: arrow keys to move, hold z to charge jump, release z to execute jump. you can only move in the air. r to reset. esc to pause.";
instance_create_depth(room_width/2, room_height/2 + 10, -1000, Text, {
	"str": _controls_text,
	"font": fnt_m5x7,
	"centered": true,
});