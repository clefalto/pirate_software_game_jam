/// @desc ACTOR STEP EVENT

if (is_enabled) {
	move(solids_layer, x_speed, on_x_collide, y_speed, on_y_collide);
	animator_update(animator);
}