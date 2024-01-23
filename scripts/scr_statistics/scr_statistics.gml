num_jumps = 0;
num_resets = 0;


function stats_add_jump() {
	global.num_jumps++;
	show_debug_message("jumps increased to " + string(global.num_jumps));
}

function stats_add_reset() {
	global.num_resets++;
	show_debug_message("resets increased to " + string(global.num_resets));
}

