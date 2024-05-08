extends Control

@export var watch_node: Control
@export var text: String = "tooltip"
@export var color: Color = Color(0, 0, 0, 1)
@export var font_size: int = 64

@onready var tool_tip_text = $ToolTipText

func _ready():
	visible = false
	watch_node.mouse_entered.connect(_on_mouse_entered)
	watch_node.mouse_exited.connect(_on_mouse_exited)
	tool_tip_text.text = text
	tool_tip_text.label_settings.set_font_color(color)
	tool_tip_text.label_settings.set_font_size(font_size)

func _on_mouse_entered():
	visible = true
	
func _on_mouse_exited():
	visible = false
