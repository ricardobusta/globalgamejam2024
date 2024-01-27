extends Node

@onready var play_button: Button = $UiCanvas/PlayButton

func _ready() -> void:
    play_button.pressed.connect(_play_button_pressed)

func _play_button_pressed() -> void:
    get_tree().change_scene_to_file("res://meta/gameplay.tscn")
