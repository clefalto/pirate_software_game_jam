time_elapsed = 0; // MILLISECONDS SINCE THE GAME STARTED

msperframe = game_get_speed(gamespeed_microseconds) / 1000;

timer_is_paused = false;

function pause_timer() {
	global.timer_is_paused = true;
}

function unpause_timer() {
	global.timer_is_paused = false;
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

function update_timer() {
	if (!global.timer_is_paused) {
		global.time_elapsed += global.msperframe;
	}
}