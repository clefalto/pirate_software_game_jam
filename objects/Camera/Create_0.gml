view_width = 320;
view_height = 180;
target = noone;

// TODO apply scale using device dimensions
aspect_scale = 4;

window_set_size(view_width*aspect_scale, view_height*aspect_scale);
display_set_gui_size(view_width, view_height);

alarm[0] = 1;

surface_resize(application_surface, view_width*aspect_scale, view_height*aspect_scale);

// do more for dynamic resolution