extends MinigameController

var cat_happines: float = 0
var cat_bit_happy: float = 1000
var cat_medium_happy: float = 2000
var cat_happy: float = 3000
var mouse_position: Vector2
var previous_mouse_position: Vector2

@onready var toy: Sprite2D = $"Toy/Toy2D"
@onready var cat: Sprite2D = $"Cat/Cat2D"

const sad_cat: Texture2D = preload("res://mini_games/catplay/sprites/sad_cat_02.png")
const neutral_cat: Texture2D = preload("res://mini_games/catplay/sprites/neutral_cat_02.png")
const happy_cat: Texture2D = preload("res://mini_games/catplay/sprites/happy_cat_02.png")
const angry_cat: Texture2D = preload("res://mini_games/catplay/sprites/angry_cat_02.png")

func _ready() -> void:
    mouse_position = get_viewport().get_mouse_position()
    previous_mouse_position = mouse_position
    toy.position = mouse_position

func _process(_delta: float) -> void:
    if _paused():
        return

    # move the toy
    mouse_position = get_viewport().get_mouse_position()
    var mouse_delta: Vector2 = mouse_position - previous_mouse_position
    toy.position = mouse_position
    previous_mouse_position = mouse_position

    # if toy moved, cat is happier
    cat_happines += mouse_delta.length()
    if cat_happines >= cat_bit_happy and cat_happines < cat_medium_happy:
        cat.texture = neutral_cat

    # if cat is happy enough, win
    if cat_happines >= cat_happy:
        cat.texture = happy_cat
        _win_game()

func timeout() -> void:
    cat.texture = angry_cat
