extends GridMap

#func _process(delta):
	#if is_being_dragged:  # Assume you have a way to check if the object is being dragged
		#position = get_global_mouse_position()  # Or however you handle positioning
		#snap_to_grid()

func snap_to_grid():
	var grid_size = Vector3(1, 1, 1)  # Adjust this based on your GridMap's cell size
	position.x = round(position.x / grid_size.x) * grid_size.x
	position.y = round(position.y / grid_size.y) * grid_size.y
	position.z = round(position.z / grid_size.z) * grid_size.z
