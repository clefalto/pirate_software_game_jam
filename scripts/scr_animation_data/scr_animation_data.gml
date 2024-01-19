/* 
animation data structs
	cnt: number of animations
	"default": animation that plays "by default" this will play when no other animations are set
	...
*/

player_animations = {
	cnt: 4,
	"default":		animation_create("default", spr_bready, 25, 0, 0, false),
	initial_jump:	animation_create("initial_jump", spr_bready, 25, 1, 2, true),
	air_spin:		animation_create("air_spin", spr_bready, 25, 3, 21, false),
	splat:			animation_create("splat", spr_bready, 25, 22, 22, true),
}

level_exit_animations = {
	cnt: 3,
	"default":		animation_create("default", spr_bready_unspready, 75, 0, 0, false),
	bounce:			animation_create("bounce", spr_bready_unspready, 75, 0, 14, true),
	unite:			animation_create("unite", spr_bready_unitey, 75, 0, 5, true),
}

toaster_animations = {
	cnt: 2,
	"default":		animation_create("default", spr_toaster, 75, 0, 0, false),
}