//width = 80;
//height = 100;

//// space between border and text
//border = 8;
//// space between lines of text
//line_space = 2;

// default values for variables (because i forgot what they were called)
//with (self) {
//	width ??= 16;
//	height ??= 16;
//	size_border ??= 4;
//	line_height ??= 8;
//	centered ??= false;
//}

self[$ "width"] ??= 16;
self[$ "height"] ??= 16;
self[$ "size_border"] ??= 4;
self[$ "line_height"] ??= 8;
self[$ "text_centered"] ??= false;
self[$ "options"] ??= [new MenuItem("no options...", fnt_m3x6, width - size_border*2, line_height)];
self[$ "centered"] ??= true;
self[$ "title"] ??= "";

if (centered) {
	// center before centering in drawgui
	x = Camera.view_width/2 - self.width/2;
	y = Camera.view_height/2 - self.height/2;
}

selected = 0;

draw_sprite_ext(sprite_index, image_index, x, y, width/sprite_width, height/sprite_height, 0, c_white, 1.0);

//num_options = array_length(options);

// FIXME hardcoded!
//options[0] = new MenuItem("start", fnt_m3x6, width - size_border*2, line_height);
//options[1] = new MenuItem("settings", fnt_m3x6, width - size_border*2, line_height);
//options[2] = new MenuItem("quit", fnt_m3x6, width - size_border*2, line_height);
