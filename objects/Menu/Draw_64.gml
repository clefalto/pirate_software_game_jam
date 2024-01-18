// center self
x = Camera.view_width/2 - self.width/2;
y = Camera.view_height/2 - self.height/2;

var _left_text_bound = x + size_border;
var _top_text_bound = y + size_border;
draw_sprite_ext(sprite_index, image_index, x, y, width/sprite_width, height/sprite_height, 0, c_white, 1.0);

var _text_orig_x = _left_text_bound;
var _text_orig_y = _top_text_bound - 5;
for (var i = 0; i < array_length(options); i++) {
	var _adj_text_orig_x = _text_orig_x;
	if (text_centered) {
		_adj_text_orig_x += (width - size_border*2)/2 - string_width(options[i].text)/2;
	}
	options[i].render_text(_adj_text_orig_x, _text_orig_y);
	if (options[i].detect_mouse()) {
		draw_set_font(fnt_m3x6);
		draw_text(_adj_text_orig_x - 5, _text_orig_y, ">");
		
		// *(still in detect_mouse() if block)
		if (options[i].trigger) {
			switch i {
				case 0: // resume
					GameManager.unpause();
				break;
				case 1: // settings
					room_goto(rm_settings);
				break;
				case 2: // quit
					game_end(0);
				break;
			}
		}
	}
	_text_orig_y += font_get_size(fnt_m3x6);
}