extends Node

class_name MinigameController

signal game_won_signal
signal game_lost_signal

@export var time: float = 5

func _win_game():
    game_won_signal.emit()

func _lose_game():
    game_lost_signal.emit()
