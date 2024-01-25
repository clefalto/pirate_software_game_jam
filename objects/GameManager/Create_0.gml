/// @desc GAME MANAGER CREATE EVENT
check_z_down_room_start();

global.is_paused = false;
global.current_frame = 0;
global.debug_enabled = false;

pause_menu = undefined;

global.all_tiles_spreaded = false;
instance_create_depth(0, 0, 0, UnlockableTileManager);


global.player_exists = false;
global.player = instance_find(Player, 0);
if (global.player != noone) {
	global.player_exists = true;
}


timer_unpause();

function pause() {
	global.is_paused = true;
	on_pause();
}

function unpause() {
	global.is_paused = false;
	on_unpause();
}

function on_pause() {
	timer_pause();
	// disable input for player (player can't move anyway if it's actordisabled but just being safe
	if (global.player_exists) {
		global.player.input_enabled = false;
	}
	// pause every actor TODO pause everything that isn't an actor SUCH AS PARTICLES and animations
	for (var _i = 0; _i < instance_number(Actor); _i++) {
		var _obj = instance_find(Actor, _i);
	
		_obj.disable(); 
	}
	
}

function on_unpause() {
	timer_unpause();
	if (global.player_exists) {
		global.player.input_enabled = true;
	}
	// enable actors
	for (var _i = 0; _i < instance_number(Actor); _i++) {
		var _obj = instance_find(Actor, _i);
	
		_obj.enable();
	}
	
	// destroy menu that definitely WAS created
	if (instance_exists(pause_menu)) {
		instance_destroy(pause_menu);
	}
}

function on_level_complete() {
	// call user_event(1) on every instance
	for (var _i = 0; _i < instance_count; _i++) {
		_obj = instance_id[_i];
		with (_obj) {
			event_user(1);
		}
	}
	
}

function on_player_die(_message = "you're toast.") {
	// pause();
	//instance_create_depth(250, 140, -1000, Menu, {
	//	"width": 100,
	//	"height": 35, 
	//	"options": [ new MenuItem("restart..", fnt_m5x7, 35-4, 8, level_restart) ],
	//	"centered": true,
	//	"title": _message,
	//});
	
	
	// wait for about 30 frames, then play screen transition, where the level restarts at the end
	event_user(0);
}

#region level specific stuff (message)


var _title_text_pos_x = 10;
var _title_text_pos_y = 20;
if (level_get_current_level() == 0) {
	//if (instance_exists(Player)) {
	//	var _player = instance_find(Player, 0);
	//	_x = _player.x;
	//	_y = _player.y
	//}
	instance_create_depth(_title_text_pos_x, _title_text_pos_y, -1000, TutorialText, {
		"str": "0: unite.",
		"duration": 80,
		"font": fnt_m5x7,
		"delay": 80,
	});
}
else if (level_get_current_level() == 1) {
	instance_create_depth(_title_text_pos_x, _title_text_pos_y, -1000, TutorialText, {
		"str": "1: jumping consumes jam.",
		"duration": 80,
		"font": fnt_m5x7,
		"delay": 80,
	});
}
else if (level_get_current_level() == 2) {
	instance_create_depth(_title_text_pos_x, _title_text_pos_y, -1000, TutorialText, {
		"str": "2: spread jam to all.",
		"duration": 80,
		"font": fnt_m5x7,
		"delay": 80,
	});
}
else if (level_get_current_level() == 3) {
	instance_create_depth(_title_text_pos_x, _title_text_pos_y, -1000, TutorialText, {
		"str": "3: againt the grain.",
		"duration": 80,
		"font": fnt_m5x7,
		"delay": 80,
	});
}
else if (level_get_current_level() == 4) {
	instance_create_depth(_title_text_pos_x, _title_text_pos_y, -1000, TutorialText, {
		"str": "4: mysterious device.",
		"duration": 80,
		"font": fnt_m5x7,
		"delay": 80,
	});
}
else if (level_get_current_level() == 5) {
	instance_create_depth(_title_text_pos_x, _title_text_pos_y, -1000, TutorialText, {
		"str": "5: you're toast. again",
		"duration": 80,
		"font": fnt_m5x7,
		"delay": 80,
	});
}
else if (level_get_current_level() == 6) {
	instance_create_depth(_title_text_pos_x, _title_text_pos_y, -1000, TutorialText, {
		"str": "6: half baked.",
		"duration": 80,
		"font": fnt_m5x7,
		"delay": 80,
	});
}
else if (level_get_current_level() == 7) {
	instance_create_depth(_title_text_pos_x, _title_text_pos_y, -1000, TutorialText, {
		"str": "7: time to rise.",
		"duration": 80,
		"font": fnt_m5x7,
		"delay": 80,
	});
}
else if (level_get_current_level() == 8) {
	instance_create_depth(_title_text_pos_x, _title_text_pos_y, -1000, TutorialText, {
		"str": "8: kneady.",
		"duration": 80,
		"font": fnt_m5x7,
		"delay": 80,
	});
}
else if (level_get_current_level() == 9) {
	instance_create_depth(_title_text_pos_x, _title_text_pos_y, -1000, TutorialText, {
		"str": "9: hot cross.",
		"duration": 80,
		"font": fnt_m5x7,
		"delay": 80,
	});
}
else if (level_get_current_level() == 10) {
	instance_create_depth(_title_text_pos_x, _title_text_pos_y, -1000, TutorialText, {
		"str": "10: on a roll.",
		"duration": 80,
		"font": fnt_m5x7,
		"delay": 80,
	});
}
else if (level_get_current_level() == 11) {
	instance_create_depth(_title_text_pos_x, _title_text_pos_y, -1000, TutorialText, {
		"str": "11: upper crust.",
		"duration": 80,
		"font": fnt_m5x7,
		"delay": 80,
	});
}
else if (level_get_current_level() == 12) {
	instance_create_depth(_title_text_pos_x, _title_text_pos_y, -1000, TutorialText, {
		"str": "12: labor of loaf.",
		"duration": 80,
		"font": fnt_m5x7,
		"delay": 80,
	});
}

#endregion