if (part_particles_count(jam_burst_part_sys) == 0) {
	part_system_destroy(jam_burst_part_sys);
	instance_destroy();
}