/// @desc TOASTER_COLLISION WITH PLAYER

if (is_enabled && !is_used) {
	// player most definitely exists
	var _player = instance_find(Player, 0);
	
	absorb_actor(_player);
	
	// animation
}