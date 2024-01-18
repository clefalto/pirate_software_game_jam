function MenuItem(_text, _font, _max_width, _line_height) constructor {
	text = _text;
	font = _font;
	max_width = _max_width;
	
	bound_top = 0;
	bound_left = 0;
	bound_right = 0;
	bound_bottom = 0;
	
	trigger = false;
	
	line_height = _line_height

	alter_text = function(_new_text) {
		self.text = _new_text;
	}
	
	render_text = function(_x, _y) {
		draw_set_font(self.font);
		//if (center) {
		//	_x += max_width/2 - string_width(text)/2;
		//}
		draw_text_ext(_x, _y, self.text, 1, self.max_width);
		
		self.bound_left = 0 + _x;
		self.bound_top = 0 + line_height/2 + _y;
		self.bound_right = string_width(text) + _x;
		self.bound_bottom = 1.5*line_height + _y;
		//draw_rectangle(self.bound_left, self.bound_top, self.bound_right, self.bound_bottom, true);
	}
	
	detect_mouse = function() {
		var _point_is = point_in_rectangle(mouse_x, mouse_y, self.bound_left, self.bound_top, self.bound_right, self.bound_bottom);
		//show_debug_message(string(mouse_x) + ", " + string(mouse_y) + ": " + string(_point_is));
		trigger = mouse_check_button_pressed(1);
		return _point_is;
	}
	
	detect_click = function() {
		return detect_mouse() && mouse_check_button_pressed(1);
	}
}