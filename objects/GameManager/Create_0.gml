/// @desc GAME MANAGER CREATE EVENT

global.is_paused = false;
global.current_frame = 0;

menu = undefined;

global.player_exists = false;
global.player = instance_find(Player, 0);
if (global.player != noone) {
	global.player_exists = true;
}

// called when level is finished (should be by LevelExit)
function on_level_finish() {
	// pop up menu or something
	
}

function pause() {
	global.is_paused = true;
	on_pause();
}

function unpause() {
	global.is_paused = false;
	on_unpause();
}

function on_pause() {
	if (global.player_exists) {
		global.player.input_enabled = false;
	}
	// pause every actor TODO pause everything that isn't an actor SUCH AS PARTICLES and animations
	for (var _i = 0; _i < instance_number(Actor); _i++) {
		var _obj = instance_find(Actor, _i);
	
		_obj.disable(); 
	}
	
	// spawn in pause menu
	menu = instance_create_depth(x, y, -1000, Menu, {
		"width": 25,
		"height": 75,
		"size_border": 4,
		"line_height": 8,
		"text_centered": true,
		"options": [new MenuItem("resume", fnt_m3x6, 25, 8), new MenuItem("options", fnt_m3x6, 25, 8)],
	});
}

function on_unpause() {
	if (global.player_exists) {
		global.player.input_enabled = true;
	}
	// enable actors
	for (var _i = 0; _i < instance_number(Actor); _i++) {
		var _obj = instance_find(Actor, _i);
	
		_obj.enable();
	}
	
	// destroy menu that definitely WAS created
	if (instance_exists(Menu)) {
		instance_destroy(menu);
	}
}