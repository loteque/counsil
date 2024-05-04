extends Node3D

class_name GamePiece

@export var board_grid_map: GridMap
@export var card_resource: CardResource

var dragging = false
var drag_offset = Vector3.ZERO
var grid_size = Vector3(0.25, 0.1, 0.25)
var original_y = 0.0
var move_limit = Vector2(grid_size.x, grid_size.z)
var original_position = Vector3.ZERO

@onready var static_body_3d: StaticBody3D = find_child("StaticBody3D")
@onready var camera = %GameCamera

func _ready():
	print("Script included")
	static_body_3d.input_ray_pickable = true

func _input(event):
	if event is InputEventMouseButton and event.is_released():
		end_dragging()
	
	if  event is InputEventMouseButton: # event is InputEventMouseMotion or
		var from = camera.project_ray_origin(event.position)
		var to = from + camera.project_ray_normal(event.position) * 10000
		var space_state = get_world_3d().direct_space_state
		var params = PhysicsRayQueryParameters3D.new()
		params.from = from
		params.to = to
		var result = space_state.intersect_ray(params)
		if result and result.collider == static_body_3d:
			if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
				if event.pressed:
					start_dragging(event)

func start_dragging(event):
	dragging = true
	original_position = global_transform.origin
	var mouse_position = event.position
	var from = camera.project_ray_origin(mouse_position)
	var to = from + camera.project_ray_normal(mouse_position) * 1000
	var space_state = get_world_3d().direct_space_state
	var params = PhysicsRayQueryParameters3D.new()
	params.from = from
	params.to = to
	var intersection = space_state.intersect_ray(params)
	if intersection:
		drag_offset = global_transform.origin - intersection.position
		original_y = global_transform.origin.y

func end_dragging():
	dragging = false
	snap_to_grid()

func _process(delta):
	update_position(delta)
	
func update_position(delta):
	if dragging:
		var mouse_position = get_viewport().get_mouse_position()
		var from = camera.project_ray_origin(mouse_position)
		var to = from + camera.project_ray_normal(mouse_position) * 1000
		var space_state = get_world_3d().direct_space_state
		var params = PhysicsRayQueryParameters3D.new()
		params.from = from
		params.to = to
		var intersection = space_state.intersect_ray(params)
		if intersection:
			var world_position = intersection.position + drag_offset
			world_position.y = original_y
			var closest_grid_position = find_closest_grid_position(world_position)
			global_transform.origin = closest_grid_position

# Convert global coordinates to map coordinates
func global_to_map(world_position: Vector3) -> Vector3:
	var local_pos = board_grid_map.to_local(world_position)
	return board_grid_map.local_to_map(local_pos)

# Convert map coordinates back to global coordinates
func map_to_global(map_position: Vector3) -> Vector3:
	var local_pos = board_grid_map.map_to_local(map_position)
	return board_grid_map.to_global(local_pos)

# Function to find the closest grid position based on a world position
func find_closest_grid_position(world_position: Vector3) -> Vector3:
	var map_pos = global_to_map(world_position)
	var original_pos_in_map = global_to_map(original_position)
	var map_translation = original_pos_in_map - map_pos
	var can_move_here = card_resource.can_move(map_translation.x + 1, map_translation.z + 1)

	if can_move_here and board_grid_map.is_on_board(map_pos):
		return map_to_global(map_pos)
	
	return original_position
	
	# Round the gridmap coordinates to snap to the nearest grid square
	#map_pos = map_pos.round()
	

	#print("Global pos: ", global)
	
	#return global


func snap_to_grid():
	var new_pos = find_closest_grid_position(global_transform.origin)
	global_transform.origin = new_pos
