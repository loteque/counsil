extends Resource

class_name card_resource

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

@export var attack: int
@export var defense: int
@export var production: int
@export var cost: int
@export var icon: ImageTexture
@export var allowed_movements: Array[Direction]
