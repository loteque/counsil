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

@export var attack: int
@export var defense: int
@export var production: int
@export var cost: int
@export var icon_img: Image
@export var icon2: ImageTexture
@export var icon3: Texture2D
@export var allowed_movements: Array[Direction]
