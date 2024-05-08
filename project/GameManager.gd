extends Node

const CURRENT_PLAYER_ID = 1

signal card_played(card: CardResource)
signal player_production_change(player_id: int, difference: int)
signal player_production_update(player_id: int, amount: int)
signal focus_card(card: CardResource) 

var player_production: Dictionary = {
	1: 0,
	2: 0
}

func _ready():
	player_production_change.connect(_on_player_production_change)
	card_played.connect(_on_card_played)

func _on_card_played(card: CardResource):
	player_production_change.emit(CURRENT_PLAYER_ID, -card.cost)

func _on_player_production_change(player_id: int, difference: int):
	player_production[player_id] = player_production[player_id] + difference
	player_production_update.emit(player_id, player_production[player_id])

func get_player_production(player_id: int):
	return player_production[player_id]

