extends Node3D

@export var card_resource: CardResource

var dragging = false
var drag_offset = Vector3.ZERO
var grid_size = Vector3(0.25, 0.1, 0.25)
var original_y = 0
var move_limit = Vector2(grid_size.x, grid_size.z)
var original_position = Vector3.ZERO

@onready var static_body_3d: StaticBody3D = find_child("StaticBody3D")
@onready var camera = %GameCamera


func _ready():
	print("SPECIAL")
	# Ensure the node captures mouse input.
	static_body_3d.input_ray_pickable = true# Adjust the path to your actual camera node

func _input(event):
	if event is InputEventMouseMotion or event is InputEventMouseButton:
		# Get the camera's ray to the mouse position
		var from = camera.project_ray_origin(event.position)
		var to = from + camera.project_ray_normal(event.position) * 1000  # Adjust the length based on your scene scale

		# Access the physics world's direct space state for querying
		var space_state = get_world_3d().direct_space_state

		# Perform the raycast
		var params: PhysicsRayQueryParameters3D = PhysicsRayQueryParameters3D.new()
		params.from = from
		params.to = to
		var result = space_state.intersect_ray(params)
		if result:
			if result.collider == static_body_3d:  # Ensure the raycast hit this object
				if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
					if event.pressed:
						start_dragging(event)
					else:
						end_dragging()

func update_position():
	var camera = get_viewport().get_camera_3d()
	var mouse_position = get_viewport().get_mouse_position()
	var from = camera.project_ray_origin(mouse_position)
	var to = from + camera.project_ray_normal(mouse_position) * 1000
	var space_state = get_world_3d().direct_space_state
	var params: PhysicsRayQueryParameters3D = PhysicsRayQueryParameters3D.new()
	params.from = from
	params.to = to
	var intersection = space_state.intersect_ray(params)
	if intersection:
		var pos = intersection.position + drag_offset
		var limited_position = limit_movement(pos)
		global_transform.origin = limited_position
		global_transform.origin = find_closest_square(original_position, limited_position)

# Function to find the closest square in a 3x3 grid where each square is 0.25 meters wide
func find_closest_square(current_position: Vector3, new_position: Vector3) -> Vector3:
	# Calculate the relative position of new_position from current_position
	var relative_position = new_position - current_position
	
	# Initialize the closest square (center square)
	var closest_square = Vector3(0, 0, 0)
	var min_distance = 1000000.0 # Start with a large number
	
	# Grid square size
	var square_size = 0.25
	
	# Iterate through each square in the 3x3 grid
	for x in range( - 1, 2):
		for y in range( - 1, 2):
			for z in range( - 1, 2):
				# Calculate the center of each square relative to the current position, scaled by square size
				var square_center = Vector3(x * square_size, y * square_size, z * square_size)
				# Calculate the distance from the new position to the center of this square
				var distance = (relative_position - square_center).length()
				# Check if this square is closer than the current closest
				if distance < min_distance and card_resource.can_move(x + 1, z + 1): # AND CAN MOVE
					min_distance = distance
					closest_square = square_center
	
	# Return the grid square closest to the new position (in global coordinates)
	return current_position + closest_square

func snap_to_grid():
	var current_position = global_transform.origin
	current_position.y = original_y # Maintain y-coordinate when snapping
	var snapped_position = current_position.snapped(grid_size)
	snapped_position.y = original_y # Ensure y remains constant after snapping
	global_transform.origin = snapped_position + Vector3(grid_size.x * 0.5, 0, grid_size.z * 0.5) # Adjust only x and z for centering

# Limit movement to be max 1 unit away in x and z directions
func limit_movement(pos: Vector3) -> Vector3:
	var x_diff = pos.x - original_position.x
	var z_diff = pos.z - original_position.z
	var limited_position = pos
	if abs(x_diff) > move_limit.x:
		limited_position.x = original_position.x + move_limit.x if x_diff > 0 else original_position.x - move_limit.x
	if abs(z_diff) > move_limit.y:
		limited_position.z = original_position.z + move_limit.y if z_diff > 0 else original_position.z - move_limit.y
	limited_position.y = original_y
	print(limited_position)
	return limited_position

func _process(delta):
	if dragging:
		update_position()

func start_dragging(event):
	original_position = global_position
	dragging = true
	var camera = get_viewport().get_camera_3d()
	var mouse_position = event.position
	var from = camera.project_ray_origin(mouse_position)
	var to = from + camera.project_ray_normal(mouse_position) * 1000
	var space_state = get_world_3d().direct_space_state
	var params: PhysicsRayQueryParameters3D = PhysicsRayQueryParameters3D.new()
	params.from = from
	params.to = to
	var intersection = space_state.intersect_ray(params)
	if intersection:
		drag_offset = global_transform.origin - intersection.position
		original_y = global_transform.origin.y # Store the original y-coordinate

func end_dragging():
	dragging = false
	#snap_to_grid()

#func snap_to_grid():
	#var current_position = global_transform.origin
	#var snapped_position = current_position.snapped(grid_size)
	#global_transform.origin = snapped_position + grid_size * 0.5
