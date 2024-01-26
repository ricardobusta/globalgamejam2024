extends Node

@onready var play_button: Button = $PlayButton

func _ready():
    play_button.pressed.connect(_play_button_pressed)

func _play_button_pressed() -> void:
    pass
