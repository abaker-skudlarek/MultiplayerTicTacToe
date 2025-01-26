extends Area2D

@export var x: int
@export var y: int


func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			GameManager.clicked_on_grid_position.rpc_id(1, x, y, GameManager.local_player_type)
