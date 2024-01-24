
instance_create_depth(room_width/2, room_height/4, 0, Text, {
	"str": "mission complete.",
	"font": fnt_m5x7,
	"centered": true,
});
instance_create_depth(room_width/2, room_height/4 + string_height("mission complete."), 0, Text, {
	"str": "jumps: " + string(global.num_jumps),
	"font": fnt_m5x7,
	"centered": true,
});
instance_create_depth(room_width/2, room_height/4 + 2*string_height("jumps: "), 0, Text, {
	"str": "resets: " + string(global.num_resets),
	"font": fnt_m5x7,
	"centered": true,
});

instance_create_depth(room_width/2, room_height/4 + 3*string_height("resets: "), 0, Menu, {
	// finish
	
	
});