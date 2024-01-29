extends Node

class_name GameOverController

@onready var score_label: Label = $GameOver/ScoreLabel
@onready var back_button: Button = $GameOver/Button

var score: int = 0

func _ready() -> void:
    back_button.pressed.connect(_go_to_title)
    set_score(score)

func set_score(value: int) -> void:
    score = value
    if score_label:
        score_label.text = "Score: %d" % value

func _go_to_title() -> void:
    get_tree().change_scene_to_file("res://meta/title_screen.tscn")
