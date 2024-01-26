extends Node

var scenes: Array = []
var active_game: MinigameController = null
var minigame_index = 0
var max_health = 5
var current_health = max_health
var health_icons: Array = []

var current_time: float

@onready var health_container: BoxContainer = $CanvasLayer/HBoxContainer
@onready var health_template: TextureRect = $CanvasLayer/HBoxContainer/TextureRect
@onready var time_bar: ProgressBar = $CanvasLayer/ProgressBar

func _ready() -> void:
    health_container.remove_child(health_template)
    for i in range(0, max_health):
        health_icons.append(health_template.duplicate());
        health_container.add_child(health_icons[i])

    scenes.append(load("res://mini_games/catplay/catplay.tscn"))
    scenes.append(load("res://mini_games/z_test_buttons/test_buttons.tscn"))
    _set_minigame(minigame_index)

func _set_minigame(index: int):
    if active_game:
        remove_child(active_game)
        active_game.queue_free()
    active_game = scenes[index].instantiate()
    active_game.game_won_signal.connect(_on_game_won)
    active_game.game_lost_signal.connect(_on_game_lost)
    current_time = active_game.time
    time_bar.max_value = active_game.time

    add_child(active_game)

func _on_game_won():
    print("Won!")
    _update_health_bar()
    _play_next_minigame()

func _on_game_lost():
    print("Lost!")
    current_health -= 1

    if current_health == 0:
        get_tree().change_scene_to_file("res://meta/title_screen.tscn")

    _update_health_bar()
    _play_next_minigame()

func _update_health_bar():
    for i in range(0, max_health):
        if i >= current_health:
            if health_icons[i].get_parent():
                health_container.remove_child(health_icons[i])
        else:
            if !health_icons[i].get_parent():
                health_container.add_child(health_icons[i])

func _play_next_minigame():
    minigame_index += 1
    minigame_index %= scenes.size()
    _set_minigame(minigame_index)

func _process(delta: float):
    current_time -= delta
    time_bar.value = current_time
    if current_time <= 0:
        _on_game_lost()
