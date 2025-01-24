extends Node

var GRID_X_START_LOCATION: int = 150
var GRID_Y_START_LOCATION: int = 570
var GRID_OFFESET: int = 210 

@export var cross_scene: PackedScene = load("res://Scenes/Circle/circle.tscn")
@export var circle_scene: PackedScene = load("res://Scenes/Cross/cross.tscn")


func _ready() -> void:
    SignalBus.connect("grid_position_clicked", _on_grid_position_clicked)


func _on_grid_position_clicked(x: int, y: int) -> void:
    spawn_piece.rpc(x, y)


func _grid_to_pixel(x: int, y: int) -> Vector2:
    return Vector2(
        int(GRID_X_START_LOCATION + (GRID_OFFESET * x)),
        int(GRID_Y_START_LOCATION + (-GRID_OFFESET * y))
    )


@rpc("call_local", "any_peer")
func spawn_piece(x: int, y: int) -> void:
    print("RPC called by: ", multiplayer.get_remote_sender_id())
    var new_piece: Node = cross_scene.instantiate()
    new_piece.position = _grid_to_pixel(x, y)
    get_tree().root.get_node("Main").add_child(new_piece)
