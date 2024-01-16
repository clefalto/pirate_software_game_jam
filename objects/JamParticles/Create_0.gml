/*
OBJECT FOR HANDLING THIS SPECIFIC PARTICLE SYSTEM (jam particles, emitted when the player hits a surface or when you
otherwise want to make a burst of jam particles
would have done this In the player object but this makes managing the particles (i.e., deleting it when necessary) easier and declutters the player object

instantiate this object at the desired place in the room where you want the burst of particles to happen
*/

// REMEMBER TO PASS IN A LAYER FOR THE PARTICLES

with (self) {
	part_layer ??= layer_create(0, "particles");
}

jam_burst_part_sys = part_system_create_layer(part_layer, false, ps_jam);
part_system_position(jam_burst_part_sys, x, y);