is_paused = false;

global.player_exists = false;
global.player = instance_find(Player, 0);
if (global.player != noone) {
	global.player_exists = true;
}

// called when level is finished (should be by LevelExit)
function on_level_finish() {
	// pop up menu or something
	
}