extends Label


func _ready() -> void:
	multiplayer.connected_to_server.connect(_on_connected_to_server)


func _on_connected_to_server() -> void:
	text = str(multiplayer.get_unique_id())
	show()
