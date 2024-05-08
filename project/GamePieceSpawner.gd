extends Node



var cards: Dictionary = {
	preload("res://card_resources/attacker-card.tres") as CardResource: preload("res://board/pieces/AtackerGamePiece.tscn") as PackedScene,
	preload("res://card_resources/heavy-attacker-card.tres") as CardResource: preload("res://board/pieces/HeavyAttackerPiece.tscn") as PackedScene,
	preload("res://card_resources/producer-card.tres") as CardResource: preload("res://board/pieces/ProducerGamePiece.tscn") as PackedScene,
	preload("res://card_resources/heavy-producer-card.tres") as CardResource: preload("res://board/pieces/HeavyProducerGamePiece.tscn") as PackedScene,
	preload("res://card_resources/scout-card.tres") as CardResource: preload("res://board/pieces/ScoutGamePiece.tscn") as PackedScene,
	preload("res://card_resources/defender-card.tres") as CardResource: preload("res://board/pieces/DefenderGamePiece.tscn") as PackedScene
	# Add more mappings as needed
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func spawn_from_card(card: CardResource) -> Node3D:
	var game_piece_scene: PackedScene = cards[card]
	var game_piece: Node3D = game_piece_scene.instantiate()
	game_piece.card_resource = card
	return game_piece
