extends MinigameController

var cat_happines: float = 0
var cat_bit_happy: float = 500
var cat_medium_happy: float = 800
var cat_happy: float = 1500
var mouse_position: Vector2
var previous_mouse_position: Vector2

@onready var toy: Sprite2D = $"Toy/Toy2D"
@onready var cat: Sprite2D = $"Cat/Cat2D"

func _ready() -> void:
    mouse_position = get_viewport().get_mouse_position()
    previous_mouse_position = mouse_position
    toy.position = mouse_position

func _process(_delta: float) -> void:
    # move the toy
    mouse_position = get_viewport().get_mouse_position()
    var mouse_delta: Vector2 = mouse_position - previous_mouse_position
    toy.position = mouse_position
    previous_mouse_position = mouse_position

    # if toy moved, cat is happier
    cat_happines += abs(mouse_delta.x) + abs(mouse_delta.y)
    if cat_happines >= cat_bit_happy and cat_happines < cat_medium_happy:
        cat.texture = preload("res://mini_games/catplay/sprites/neutral_cat.png")

    # if cat is happy enough, win
    if cat_happines >= cat_happy:
        cat.texture = preload("res://mini_games/catplay/sprites/happy_cat.png")
        _win_game()

func timeout() -> void:
    print("cat is sad")
