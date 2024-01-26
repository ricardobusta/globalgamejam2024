extends Node

class_name MinigameController

signal game_won_signal
signal game_lost_signal

func _win_game():
    game_won_signal.emit()

func _lose_game():
    game_lost_signal.emit()
