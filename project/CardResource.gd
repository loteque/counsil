extends Resource

class_name CardResource

enum Direction {
	FORWARD,
	FORWARD_RIGHT,
	RIGHT,
	BACK_RIGHT,
	BACK,
	BACK_LEFT,
	LEFT,
	FORWARD_LEFT
}

var move_grid = [
	[Direction.FORWARD_LEFT, Direction.FORWARD, Direction.FORWARD_RIGHT],
	[Direction.LEFT, - 1, Direction.RIGHT],
	[Direction.BACK_LEFT, Direction.BACK, Direction.BACK_RIGHT]
]

@export var attack: int
@export var defense: int
@export var production: int
@export var cost: int
@export var icon_img: Image
@export var icon2: ImageTexture
@export var icon3: Texture2D
@export var allowed_movements: Array[Direction]

func get_movement(x: int, y: int):
	return move_grid[x][y]

func can_move(x, y):
	if x > 2 or y > 2 or x < 0 or y < 0:
		return false
	if x == 1 and y == 1:
		return true
	return get_movement(x, y) in allowed_movements
