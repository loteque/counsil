extends Control

@onready var card_preview_container = $CardPreviewContainer

var card_scene: PackedScene = load("res://Card.tscn")
var card_node: Control

func _ready():
	GameManager.focus_card.connect(_on_card_focussed)

func _on_card_focussed(card: CardResource):
	card_node = card_scene.instantiate()
	card_node.card_resource = card
	card_preview_container.add_child(card_node)

func _process(delta):
	pass
