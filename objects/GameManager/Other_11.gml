/// @desc GAMEMANAGER_PLAYER REACH EXIT EVENT

instance_create_depth(250, 140, -1000, Menu, {
	"width": 60,
	"height": 35, 
	"options": [ new MenuItem("continue", fnt_m3x6, 35-4, 8, level_goto_next) ],
	"centered": false,
	"title": "complete!",
});