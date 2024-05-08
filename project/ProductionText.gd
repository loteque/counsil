extends Label

# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.player_production_update.connect(_on_player_production_update)
	pass # Replace with function body.

func _on_player_production_update(player_id: int, production: int):
	if GameManager.CURRENT_PLAYER_ID == player_id:
		text = str(production)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
