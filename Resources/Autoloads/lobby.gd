extends Node

const PORT: int = 7000
const DEFAULT_SERVER_IP: String = "localhost"
const MAX_CONNECTIONS: int = 2


func _ready():
	SignalBus.connect("join_game_clicked", _on_join_game_clicked)
	SignalBus.connect("create_game_clicked", _on_create_game_clicked)
	multiplayer.peer_connected.connect(_on_peer_connected)


func _on_join_game_clicked() -> void:
	print("joining game")
	var peer = ENetMultiplayerPeer.new()
	peer.create_client(DEFAULT_SERVER_IP, PORT)
	multiplayer.multiplayer_peer = peer


func _on_create_game_clicked() -> void:
	print("creating game")
	var peer = ENetMultiplayerPeer.new()
	peer.create_server(PORT, MAX_CONNECTIONS)
	multiplayer.multiplayer_peer = peer


func _on_peer_connected(id: int) -> void:
	print("peer %s connected" % id)
