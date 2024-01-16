// math functions that aren't built in for some reason
function appr(_val, _target, _amount) {
	return (_val > _target ? max(_val - _amount, _target) : min(_val + _amount, _target));
}

function wrap(_val, _min, _max) {
	var value = floor(_val);
	var range = _max - _min + 1; // + 1 is because max bound is inclusive

	return (((value - _min) % range) + range) % range + _min;
}