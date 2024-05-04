extends GridMap

var item_script = preload("res://board/pieces/GamePiece.gd")

#func _process(delta):
	#if is_being_dragged:  # Assume you have a way to check if the object is being dragged
		#position = get_global_mouse_position()  # Or however you handle positioning
		#snap_to_grid()

func _set_cell_item(position: Vector3i, item: int, orientation: int = 0):
	set_cell_item(position, item, orientation)
	print(item)
	



func snap_to_grid():
	var grid_size = Vector3(1, 1, 1)  # Adjust this based on your GridMap's cell size
	position.x = round(position.x / grid_size.x) * grid_size.x
	position.y = round(position.y / grid_size.y) * grid_size.y
	position.z = round(position.z / grid_size.z) * grid_size.z
