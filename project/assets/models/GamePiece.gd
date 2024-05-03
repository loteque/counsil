extends Node3D

# Signal to detect when dragging starts
signal dragging_started
# Signal to detect when dragging ends
signal dragging_ended

var is_being_dragged = false
var drag_offset = Vector3.ZERO

#func _ready():
	#input_ray_pickable = true  # Make sure the node is pickable

func _input(event):
	if event is InputEventMouseMotion and is_being_dragged:
		# Handle dragging
		var camera = get_viewport().get_camera()
		var from = camera.project_ray_origin(event.position)
		var to = from + camera.project_ray_normal(event.position) * 1000
		var space_state = get_world_3d().direct_space_state
		var query = PhysicsRayQueryParameters3D.new()
		query.from = from
		query.to = to
		var result = space_state.intersect_ray(query)
		if result and result.collider == self:
			position = result.position + drag_offset
	elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			# Try to detect if we are clicking on the object
			var camera = get_viewport().get_camera_3d()
			var from = camera.project_ray_origin(event.position)
			var to = from + camera.project_ray_normal(event.position) * 1000
			var space_state = get_world_3d().direct_space_state
			var query = PhysicsRayQueryParameters3D.new()
			query.from = from
			query.to = to
			var result = space_state.intersect_ray(query)
			if result and result.collider == self:
				is_being_dragged = true
				drag_offset = position - result.position
				emit_signal("dragging_started")
				set_process(true)
		else:
			if is_being_dragged:
				is_being_dragged = false
				emit_signal("dragging_ended")
				set_process(false)
