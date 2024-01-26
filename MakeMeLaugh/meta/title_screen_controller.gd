extends Node

@onready var play_button: Button = $PlayButton

func _ready():
    play_button.pressed.connect(_play_button_pressed)

func _play_button_pressed() -> void:
    get_tree().change_scene_to_file("res://meta/gameplay.tscn")
