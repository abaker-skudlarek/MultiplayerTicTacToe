extends Node

var GRID_X_START_LOCATION: int = 150
var GRID_Y_START_LOCATION: int = 570
var GRID_OFFESET: int = 210 

@export var circle_scene: PackedScene = load("res://Scenes/Circle/circle.tscn")
@export var cross_scene: PackedScene = load("res://Scenes/Cross/cross.tscn")


func _ready() -> void:
    SignalBus.connect("grid_position_clicked", _on_grid_position_clicked)


func _on_grid_position_clicked(x: int, y: int, player_type: GameManager.PlayerType) -> void:
    # Calling with rpc_id(1) means that the rpc is called on the server, and since "any_peer" is used, the peer can call it. So the client
    # is requesting that the server call the spawn_piece function
    spawn_piece.rpc_id(1, x, y, player_type)


# call_local = function can be called on the local peer, needed because the server is also a player
# any_peer = clients are allowed to call this remotely
@rpc("call_local", "any_peer", "reliable")
func spawn_piece(x: int, y: int, player_type: GameManager.PlayerType) -> void:
    var piece_scene: PackedScene = cross_scene if player_type == GameManager.PlayerType.CROSS else circle_scene
    var new_piece: Node = piece_scene.instantiate()
    new_piece.position = _grid_to_pixel(x, y)
    get_tree().root.get_node("Main").add_child(new_piece, true)


func _grid_to_pixel(x: int, y: int) -> Vector2:
    return Vector2(
        int(GRID_X_START_LOCATION + (GRID_OFFESET * x)),
        int(GRID_Y_START_LOCATION + (-GRID_OFFESET * y))
    )
