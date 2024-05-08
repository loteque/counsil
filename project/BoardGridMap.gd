extends GridMap

var x_min = -2
var x_max = 1
var z_min = -2
var z_max = 1

var pieces: Array[Node3D] = []
var grid = [[],[],[]]

var test_piece: PackedScene = load("res://board/pieces/AtackerGamePiece.tscn")

@onready var game_piece_spawner = $GamePieceSpawner



func is_on_board(pos: Vector3) -> bool:
	return (x_min <= pos.x and pos.x <= x_max) and (z_min <= pos.z and pos.z <= z_max)

func _ready():
	GameManager.card_played.connect(_on_card_played)
	var pos = local_to_map(Vector3(0, 0, 0))
	print(pos)
	var piece = test_piece.instantiate()
	#spawn_on_grid(0, 0, piece)
#func _process(delta):
	#if is_being_dragged:  # Assume you have a way to check if the object is being dragged
		#position = get_global_mouse_position()  # Or however you handle positioning
		#snap_to_grid()

func global_to_map(world_position: Vector3) -> Vector3:
	var local_pos = to_local(world_position)
	return local_to_map(local_pos)

# Convert map coordinates back to global coordinates
func map_to_global(map_position: Vector3) -> Vector3:
	var local_pos = map_to_local(map_position)
	return to_global(local_pos)


func _set_cell_item(position: Vector3i, item: int, orientation: int = 0):
	set_cell_item(position, item, orientation)
	print(item)
	

func spawn_on_grid(x: int, z: int, piece: Node3D):
	pieces.append(piece)
	var position = map_to_global(Vector3(0, 0, 0))
	piece.board_grid_map = self
	add_child(piece)
	piece.global_position = position
	

func _on_card_played(card: CardResource):
	var game_piece: Node3D = game_piece_spawner.spawn_from_card(card)
	spawn_on_grid(0, 0, game_piece)


func snap_to_grid():
	var grid_size = Vector3(1, 1, 1)  # Adjust this based on your GridMap's cell size
	position.x = round(position.x / grid_size.x) * grid_size.x
	position.y = round(position.y / grid_size.y) * grid_size.y
	position.z = round(position.z / grid_size.z) * grid_size.z
