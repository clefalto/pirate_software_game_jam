timer_pause();
timer_unrender();

instance_create_depth(room_width/2, room_height/4, 0, Text, {
	"str": "mission complete.",
	"font": fnt_m5x7,
	"centered": true,
});

instance_create_depth(room_width/2, room_height/4 + string_height("mission complete."), 0, Text, {
	"str": "final time: " + string(format_time(global.time_elapsed)),
	"font": fnt_m5x7,
	"centered": true,
	"color": c_red,
});

instance_create_depth(room_width/2, room_height/4 + 2*string_height("mission complete."), 0, Text, {
	"str": "jumps: " + string(global.num_jumps),
	"font": fnt_m5x7,
	"centered": true,
	"color": c_aqua,
});

instance_create_depth(room_width/2, room_height/4 + 3*string_height("jumps: "), 0, Text, {
	"str": "resets: " + string(global.num_resets),
	"font": fnt_m5x7,
	"centered": true,
	"color": c_blue,
});

instance_create_depth(3*room_width/4, room_height/2, 0, Menu, {
	// finish
	"width": 50,
	"height": 50,
	"options": [ new MenuItem("restart", fnt_m5x7, 90-3, 4, global.restart_game), new MenuItem("quit", fnt_m5x7, 90 - 3, 4, game_end)] ,
	"centered": false,
	"text_centered": true,
	"title": "",
	
});

instance_create_depth(room_width/2,  room_height/4 + 4*string_height("jumps: "), 0, Text, {
	"str": "thank you for playing. i loaf you <3",
	"font": fnt_m5x7,
	"centered": true,
});

instance_create_depth(room_width/2,  room_height/4 + 5*string_height("jumps: ") + 40, 0, Text, {
	"str": "made with <3 by clef",
	"font": fnt_m5x7,
	"centered": true,
	"color": c_green,
});