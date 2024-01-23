jump_down_since_last_room = false;

// call at the end of a room to see if the player is still holding 
function check_z_down_room_end() {
	if (keyboard_check(ord("Z"))) {
		global.jump_down_since_last_room = true;
	}
}

function check_z_down_room_start() {
	if (!keyboard_check(ord("Z"))) {
		global.jump_down_since_last_room = false;
	}
}