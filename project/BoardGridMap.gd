extends GridMap

var x_min = -2
var x_max = 1
var z_min = -2
var z_max = 1

func is_on_board(pos: Vector3) -> bool:
	return (x_min <= pos.x and pos.x <= x_max) and (z_min <= pos.z and pos.z <= z_max)

func _ready():
	var pos = local_to_map(Vector3(0, 0, 0))
	print(pos)
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
