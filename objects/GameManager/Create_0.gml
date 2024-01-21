/// @desc GAME MANAGER CREATE EVENT

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

function on_player_die(_message = "ded") {
	pause();
	instance_create_depth(250, 140, -1000, Menu, {
		"width": 70,
		"height": 35, 
		"options": [ new MenuItem("restart..", fnt_m5x7, 35-4, 8, level_restart) ],
		"centered": true,
		"title": _message,
	});
}