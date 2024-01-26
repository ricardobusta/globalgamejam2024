extends Node

var scenes = ["res://mini_games/z_test_buttons/test_buttons.tscn"]

func _ready() -> void:
    var scene: PackedScene = load("res://mini_games/z_test_buttons/test_buttons.tscn")
    add_child(scene.instantiate())
