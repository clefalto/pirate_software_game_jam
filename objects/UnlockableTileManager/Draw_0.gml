//var surface = surface_create(surface_get_width(application_surface), surface_get_height(application_surface));
//draw_clear_alpha(c_black, 1);


//effect_create_layer()

//if (layer_exists("spreadables")) {
//	surface_spreadables_tiles = surface_create(room_width, room_height);
//	surface_spreadables_mask = surface_create(room_width, room_height);
	
//	layer_set_visible(spreadables_layer, false);
	
//	surface_set_target(surface_spreadables_tiles);
//		// draw_surface(surface_spreadables_mask, 0, 0);
//		draw_tilemap(spreadables_tilemap, 0, 0);
//	surface_reset_target();
	
//	surface_set_target(surface_spreadables_mask);
//	shader_set(sh_outline);
//		var outline_color = shader_get_uniform(sh_outline, "outlineColor");
//		shader_set_uniform_f(outline_color, 1.0, 1.0, 1.0, 0.0);
	
//		var outline_w = shader_get_uniform(sh_outline, "outlineW");
//		shader_set_uniform_f(outline_w, 1.0/8.0);
	
//		var outline_h = shader_get_uniform(sh_outline, "outlineH");
//		shader_set_uniform_f(outline_w, 1.0/8.0);
//		draw_surface(surface_spreadables_tiles, 0, 0);
//	shader_reset();
//	surface_reset_target();
	
//	surface_set_target(surface_spreadables_tiles);
//		draw_surface(surface_spreadables_mask, 0, 0);
//	surface_reset_target();
	
//	draw_surface(surface_spreadables_tiles, 0, 0);
//}

render_spreadable_outlines();