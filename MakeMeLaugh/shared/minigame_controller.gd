extends Node

class_name MinigameController

signal game_won_signal
signal game_lost_signal

@export var time: float = 5

func _win_game() -> void:
    game_won_signal.emit()

func _lose_game() -> void:
    game_lost_signal.emit()

func timeout() -> void:
    assert(false, "method not implemented, override timeout in minigame")
