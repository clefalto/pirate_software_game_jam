/* 
animation data structs
	cnt: number of animations
	"default": animation that plays "by default" this will play when no other animations are set
	...
*/

player_animations = {
	cnt: 4,
	"default":		animation_create("default", spr_bready, 25, 0, 0, false),
	squish:			animation_create("squish", spr_bready, 25, 1, 2, true),
	initial_jump:	animation_create("initial_jump", spr_bready, 25, 3, 4, true),
	air_spin:		animation_create("air_spin", spr_bready, 25, 4, 23, false),
	splat:			animation_create("splat", spr_bready, 25, 24, 24, true),
}

level_exit_animations = {
	cnt: 3,
	"default":		animation_create("default", spr_bready_unspready, 75, 0, 0, false),
	bounce:			animation_create("bounce", spr_bready_unspready, 75, 0, 14, true),
	unite:			animation_create("unite", spr_bready_unitey, 75, 0, 8, true),
}

toaster_animations = {
	cnt: 2,
	"default":		animation_create("default", spr_toaster, 75, 0, 0, false),
	absorb:			animation_create("absorb", spr_toaster, 75, 1, 8, false),
	fling:			animation_create("fling", spr_toaster, 100, 9, 9, true),
	used:			animation_create("used", spr_toaster, 75, 10, 10, false),
}