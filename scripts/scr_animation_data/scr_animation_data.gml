player_animations = {
	cnt: 4,
	grounded:		animation_create("grounded", spr_bready, 25, 0, 0, false),
	initial_jump:	animation_create("initial_jump", spr_bready, 25, 1, 2, true),
	air_spin:		animation_create("air_spin", spr_bready, 25, 3, 21, false),
	splat:			animation_create("splat", spr_bready, 25, 22, 22, true),
}

level_exit_animations = {
	cnt: 2,
	normal:			animation_create("normal", spr_bready_unspready, 75, 0, 0, false),
	bounce:			animation_create("bounce", spr_bready_unspready, 75, 0, 14, true),
}