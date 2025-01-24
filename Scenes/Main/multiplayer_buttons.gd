extends VBoxContainer


func _on_join_game_pressed():
	hide()
	SignalBus.emit_signal("join_game_clicked")


func _on_create_game_pressed():
	hide()
	SignalBus.emit_signal("create_game_clicked")
