extends Control

@onready var arrow_circle_image: TextureRect = $ArrowCircleImage
@onready var arrow_cross_image: TextureRect = $ArrowCrossImage
@onready var you_cross_label: Label = $YouCrossLabel
@onready var you_circle_label: Label = $YouCircleLabel


# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.connect("game_started", _on_game_started)
	SignalBus.connect("turn_taken", _on_turn_taken)
	arrow_circle_image.visible = false
	arrow_cross_image.visible = false
	you_cross_label.visible = false
	you_circle_label.visible = false


func _on_game_started() -> void:
	if GameManager.local_player_type == GameManager.PlayerType.CROSS:
		you_cross_label.visible = true	
	else:
		you_circle_label.visible = true	
	_update_current_arrow()	


func _on_turn_taken() -> void:
	_update_current_arrow()


func _update_current_arrow() -> void:
	if GameManager.current_playable_player_type == GameManager.PlayerType.CROSS:
		arrow_cross_image.visible = true
		arrow_circle_image.visible = false
	else:
		arrow_cross_image.visible = false 
		arrow_circle_image.visible = true 
