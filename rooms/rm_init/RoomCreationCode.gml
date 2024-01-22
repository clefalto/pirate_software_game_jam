// create camera
instance_create_depth(0, 0, 0, Camera);
// create gamemanager
instance_create_depth(0, 0, 0, GameManager);

// add GameManager and Camera to every room (way easier than adding them manually)
for (var _i = 1; room_exists(_i); _i++) {
	room_instance_add(_i, 0, 0, GameManager);
	room_instance_add(_i, 0, 0, Camera);
	room_instance_add(_i, 0, 0, DebugDisplay);
}

// go to title room
room_goto(2);