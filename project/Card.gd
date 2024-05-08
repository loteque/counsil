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

# vertical distace a card is moved to be considered played
@export var card_play_distance_px: int = 180

@export var card_resource_src: Node
@export var card_resource: CardResource

@onready var attack_label: Label = $AttackLabel
@onready var defense_label: Label = $DefenseLabel
@onready var production_label: Label = $ProductionLabel
@onready var cost_label: Label = $CostLabel

@onready var Icon: TextureRect = $Icon

@onready var forward_arrow = $ForwardArrow
@onready var forward_right_arrow = $ForwardRightArrow
@onready var right_arrow = $RightArrow
@onready var back_right_arrow = $BackRightArrow
@onready var back_arrow = $BackArrow
@onready var back_left_arrow = $BackLeftArrow
@onready var left_arrow = $LeftArrow
@onready var forward_left_arrow = $ForwardLeftArrow

var starting_position: Vector2
var dragging = false
var drag_offset = Vector2()

func _on_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				focus_card(card_resource)
				# Start dragging
				dragging = true
				starting_position = global_position
				drag_offset = global_position - get_global_mouse_position()
				#get_tree().set_input_as_handled()
			else:
				release_card()
	elif event is InputEventMouseMotion and dragging:
		# Handle dragging
		global_position = get_global_mouse_position() + drag_offset
		#get_tree().set_input_as_handled()

func focus_card(card: CardResource):
	GameManager.focus_card.emit(card)

func can_afford() -> bool:
	var current_prod = GameManager.get_player_production(GameManager.CURRENT_PLAYER_ID)
	var prod_cost = card_resource.cost
	return current_prod >= prod_cost

func release_card():
	dragging = false
	var is_play_distance = -(global_position - starting_position).y > card_play_distance_px
	if is_play_distance and can_afford():
		play_card()
	else:
		put_card_back()

	
func put_card_back():
	global_position = starting_position

func _ready():
	connect("gui_input", _on_gui_input)
	if card_resource_src and card_resource_src.card_resource:
		card_resource = card_resource_src.card_resource
	
	attack_label.text = str(card_resource.attack)
	defense_label.text = str(card_resource.defense)
	production_label.text = str(card_resource.production)
	cost_label.text = str(card_resource.cost)
	
	forward_arrow.visible = card_resource.allowed_movements.count(Direction.FORWARD) > 0
	forward_right_arrow.visible = card_resource.allowed_movements.count(Direction.FORWARD_RIGHT) > 0
	right_arrow.visible = card_resource.allowed_movements.count(Direction.RIGHT) > 0
	back_right_arrow.visible = card_resource.allowed_movements.count(Direction.BACK_RIGHT) > 0
	back_arrow.visible = card_resource.allowed_movements.count(Direction.BACK) > 0
	back_left_arrow.visible = card_resource.allowed_movements.count(Direction.BACK_LEFT) > 0
	left_arrow.visible = card_resource.allowed_movements.count(Direction.LEFT) > 0
	forward_left_arrow.visible = card_resource.allowed_movements.count(Direction.FORWARD_LEFT) > 0
	
	Icon.texture = ImageTexture.create_from_image(card_resource.icon_img)

func play_card():
	GameManager.card_played.emit(card_resource)
	queue_free()
