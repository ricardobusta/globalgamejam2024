extends Node

var scenes: Array
var active_game: MinigameController
var i = 0

func _ready() -> void:
    scenes.append(load("res://mini_games/catplay/catplay.tscn"))
    scenes.append(load("res://mini_games/z_test_buttons/test_buttons.tscn"))
    _set_scene(i)

func _set_scene(index: int):
    if active_game:
        remove_child(active_game)
        active_game.queue_free()
    active_game = scenes[index].instantiate()
    active_game.game_won_signal.connect(_on_game_won)
    active_game.game_lost_signal.connect(_on_game_lost)
    add_child(active_game)

func _on_game_won():
    print("Won!")
    i += 1
    i %= scenes.size()
    _set_scene(i)

func _on_game_lost():
    print("Lost!")
    i += 1
    i %= scenes.size()
    _set_scene(i)
