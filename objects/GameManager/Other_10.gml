/// @desc GAME MANAGER PLAYER DIE CUSTOM EVENT

show_debug_message("player die called");

timer_pause();

instance_create_depth(-360, 0, -1000, ScreenWipe, {
	"is_for_restart": true
});

//alarm[0] = 30;