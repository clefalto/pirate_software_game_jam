active_particle_systems = array_create(0);

/// @param _ps: particle system to instantiate
/// @returns id of the particle system that Was spawned
function part_manager_create_particles(_ps, _x, _y, _part_layer) {
	var _part_sys = part_system_create_layer(_part_layer, false, _ps);
	part_system_automatic_update(_part_sys, false);
	array_push(global.active_particle_systems, _part_sys);
	part_system_position(_part_sys, _x, _y);
	
	return _part_sys;
}

function part_manager_update_particles() {
	for (var _i = 0; _i < array_length(global.active_particle_systems); _i++) {
		var _ps = array_get(global.active_particle_systems, _i);
		if (part_system_exists(_ps)) {
			if (part_particles_count(_ps) == 0) {
				part_system_destroy(_ps);
				array_delete(global.active_particle_systems, _i, 1);
				return;
			}
			part_system_update(_ps);
		}
	}
}

function part_manager_move_particles(_ps, _x, _y) {
	part_system_position(_ps, _x, _y);
}

function part_manager_cleanup() {
	for (var _i = 0; _i < array_length(global.active_particle_systems); _i++) {
		var _ps = array_get(global.active_particle_systems, _i)
		part_system_destroy(_ps);
		array_delete(global.active_particle_systems, _i, 1);
	}
}