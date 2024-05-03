extends HBoxContainer

# Time for the nodes to move to new positions
var animation_time = 0.5


func remove_child_with_animation(child):
	var initial_positions = []
	for a_child in get_children():
		initial_positions.append(a_child.rect_position.x)
	
	# Remove the child
	remove_child(child)
	# Optionally queue_free if you want to delete the node completely
	child.queue_free()

	# Disable sorting
	#set("custom_constants/separation", -10000)

	# Animate remaining children to their new positions
	for i in range(get_child_count()):
		var node = get_child(i)
		var initial_pos = initial_positions[i]
		var target_pos = i * (node.rect_min_size.x)
		node.rect_position.x = initial_pos  # Set to initial position for smooth animation
		animate_position(node, initial_pos, target_pos)

	# Re-enable sorting after animation
	await get_tree().create_timer(animation_time).timeout
	set("custom_constants/separation", 0)

func animate_position(node, initial_pos, target_pos):
	var animation = Animation.new()
	animation.add_track(Animation.TYPE_VALUE)
	animation.track_set_path(0, "rect_position:x")
	animation.track_insert_key(0, 0.0, initial_pos)
	animation.track_insert_key(0, animation_time, target_pos)
	animation.track_set_interpolation_type(0, Animation.INTERPOLATION_CUBIC)

	var anim_player = AnimationPlayer.new()
	add_child(anim_player)
	anim_player.playback_process_mode = AnimationPlayer.ANIMATION_PROCESS_PHYSICS
	anim_player.add_animation("move", animation)
	anim_player.play("move")
	anim_player.connect("animation_finished", queue_free)
