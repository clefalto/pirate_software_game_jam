

if (is_enabled && !is_used) {
	var _player = instance_find(Player, 0);
	
	_player.restore_spread_meter();
	
	// TODO PLAY ANIMATION. some kind of drain or bloogle and droogle (iykyk)
	
	is_used = true;
}