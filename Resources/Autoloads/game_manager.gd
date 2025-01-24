extends Node


func clicked_on_grid_positon(x: int, y: int) -> void:
    SignalBus.grid_position_clicked.emit(x, y)