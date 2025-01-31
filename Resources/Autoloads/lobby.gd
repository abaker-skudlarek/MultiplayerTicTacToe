extends Node

const PORT: int = 7000
const DEFAULT_SERVER_IP: String = "localhost"
const MAX_CONNECTIONS: int = 2

var connected_players = 0

func _ready():
	SignalBus.connect("join_game_clicked", _on_join_game_clicked)
	SignalBus.connect("create_game_clicked", _on_create_game_clicked)


func _on_join_game_clicked() -> void:
	var peer = ENetMultiplayerPeer.new()
	peer.create_client(DEFAULT_SERVER_IP, PORT)
	multiplayer.multiplayer_peer = peer
	SignalBus.connected_to_game.emit()


func _on_create_game_clicked() -> void:
	var peer = ENetMultiplayerPeer.new()
	peer.create_server(PORT, MAX_CONNECTIONS)
	multiplayer.multiplayer_peer = peer
	SignalBus.connected_to_game.emit()


@rpc("any_peer", "call_local", "reliable")
func player_connected():
	if multiplayer.is_server():
		connected_players += 1
		if connected_players == MAX_CONNECTIONS:
			SignalBus.game_started.emit()	