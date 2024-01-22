time_elapsed = 0; // MILLISECONDS SINCE THE GAME STARTED

msperframe = game_get_speed(gamespeed_microseconds) / 1000;

timer_is_paused = false;
display_timer = true;

function timer_pause() {
	global.timer_is_paused = true;
}

function timer_unpause() {
	global.timer_is_paused = false;
}

function timer_unrender() {
	global.display_timer = false;
}

function timer_render() {
	global.display_timer = true;
}

// format given time (in milliseconds to min : sec . ms)
function format_time(_t) {
	var _minutes = _t / 60000;
	_minutes = floor(_minutes);
	if (_minutes < 1) _minutes = 0
	var _minutes_string = string(_minutes);
	if (_minutes < 10) {
		_minutes_string = string_concat("0", _minutes_string);
	}
	
	var _adj_min = _t mod 60000;
	
	var _seconds = _adj_min / 1000;
	
	if (_seconds < 1) _seconds = 0;
	_seconds = floor(_seconds);
	var _seconds_string = string(_seconds);
	if (_seconds < 10) {
		_seconds_string = string_concat("0", _seconds_string);
	}
	
	var _adj_sec = _adj_min mod 1000;
	
	var _milliseconds = _adj_sec;
	_milliseconds = floor(_milliseconds);
	var _milliseconds_string = string(_milliseconds);
	if (_milliseconds < 100) {
		_milliseconds_string = string_concat("0", _milliseconds_string);
	}
	if (_milliseconds < 10) {
		_milliseconds_string = string_concat("0", _milliseconds_string);
	}
	
	//return (string(_minutes) + ":" + string(_seconds) + "." + string(_milliseconds));
	
	return (_minutes_string + ":" + _seconds_string + "." + _milliseconds_string);
}

function timer_update() {
	if (!global.timer_is_paused) {
		global.time_elapsed += global.msperframe;
	}
}

function timer_draw(_x, _y) {
	draw_set_font(fnt_m5x7);
	if (global.display_timer) {
		var _time = format_time(global.time_elapsed);
		draw_sprite_stretched_ext(spr_text_background, 0, _x - 1, _y + 2, string_width(_time) + 1, string_height(_time) - 3, c_white, 0.70);
		draw_text(_x, _y, _time);
	}
}