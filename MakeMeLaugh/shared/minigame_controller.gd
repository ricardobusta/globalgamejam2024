extends Node

class_name MinigameController

signal game_won_signal
signal game_lost_signal

@export var time: float = 5
@export var action: String = "Call to action!"

var game_over: bool = false
var started: bool = false

func _paused() -> bool:
    return !started or game_over

func _win_game() -> void:
    game_over = true
    game_won_signal.emit()

func _lose_game() -> void:
    game_over = true
    game_lost_signal.emit()

func start() -> void:
    started = true

func timeout() -> void:
    assert(false, "method not implemented, override timeout in minigame")
