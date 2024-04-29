extends Control

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

@export var allowed_movements: Array[Direction] = []

@onready var attack_label: Label = $AttackLabel
@onready var defense_label: Label = $DefenseLabel
@onready var production_label: Label = $ProductionLabel
@onready var cost_label: Label = $CostLabel

@onready var Icon: Sprite2D = $Icon

@onready var forward_arrow = $ForwardArrow
@onready var forward_right_arrow = $ForwardRightArrow
@onready var right_arrow = $RightArrow
@onready var back_right_arrow = $BackRightArrow
@onready var back_arrow = $BackArrow
@onready var back_left_arrow = $BackLeftArrow
@onready var left_arrow = $LeftArrow
@onready var forward_left_arrow = $ForwardLeftArrow

func _ready():
	attack_label.text = str(attack)
	defense_label.text = str(defense)
	production_label.text = str(production)
	cost_label.text = str(cost)
	
	forward_arrow.visible = allowed_movements.count(Direction.FORWARD) > 0
	forward_right_arrow.visible = allowed_movements.count(Direction.FORWARD_RIGHT) > 0
	right_arrow.visible = allowed_movements.count(Direction.RIGHT) > 0
	back_right_arrow.visible = allowed_movements.count(Direction.BACK_RIGHT) > 0
	back_arrow.visible = allowed_movements.count(Direction.BACK) > 0
	back_left_arrow.visible = allowed_movements.count(Direction.BACK_LEFT) > 0
	left_arrow.visible = allowed_movements.count(Direction.LEFT) > 0
	forward_left_arrow.visible = allowed_movements.count(Direction.FORWARD_LEFT) > 0
