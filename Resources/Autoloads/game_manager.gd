extends Node

enum PlayerType {
    NONE,
    CROSS,
    CIRCLE
}

var local_player_type: PlayerType
var current_playable_player_type: PlayerType

func _ready() -> void:
    SignalBus.connect("connected_to_game", _on_connected_to_game)
    SignalBus.connect("game_started", _on_game_started)


func _on_connected_to_game() -> void:  
    if multiplayer.is_server():
        local_player_type = PlayerType.CROSS
    else:
        local_player_type = PlayerType.CIRCLE
    Lobby.player_connected.rpc_id(1)
    

func _on_game_started() -> void:
    current_playable_player_type = PlayerType.CROSS


@rpc("call_local", "any_peer", "reliable")
func clicked_on_grid_position(x: int, y: int, player_type: GameManager.PlayerType) -> void:
    if current_playable_player_type != player_type: return

    SignalBus.grid_position_clicked.emit(x, y, player_type)

    if current_playable_player_type == PlayerType.CROSS:
        current_playable_player_type = PlayerType.CIRCLE
    else:
        current_playable_player_type = PlayerType.CROSS

    SignalBus.turn_taken.emit()
