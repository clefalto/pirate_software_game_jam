/// @desc GAMEMANAGER_PLAYER REACH EXIT EVENT

//instance_create_depth(250, 140, -1000, Menu, {
//	"width": 70,
//	"height": 35, 
//	"options": [ new MenuItem("continue", fnt_m5x7, 35-4, 8, level_goto_next) ],
//	"centered": false,
//	"title": "complete!",
//});
instance_create_depth(-360, 0, -1000, ScreenWipe, {
	"is_for_restart": false
});

timer_pause();