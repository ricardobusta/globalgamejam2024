extends MinigameController

var cat_happines = 0
var cat_bit_happy = 500
var cat_medium_happy = 800
var cat_happy = 1500
var mouse_position
var previous_mouse_position

@onready var toy = $"Toy/Toy2D"
@onready var cat = $"Cat/Cat2D"

# Called when the node enters the scene tree for the first time.
func _ready():
    mouse_position = get_viewport().get_mouse_position()
    previous_mouse_position = mouse_position
    toy.position = mouse_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    # move the toy
    mouse_position = get_viewport().get_mouse_position()
    var mouse_delta = mouse_position - previous_mouse_position
    toy.position = mouse_position
    previous_mouse_position = mouse_position

    # if toy moved, cat is happier
    cat_happines += abs(mouse_delta.x) + abs(mouse_delta.y)
    print("cat happines: " + str(cat_happines))
    if cat_happines >= cat_bit_happy and cat_happines < cat_medium_happy:
        cat.texture = preload("res://mini_games/catplay/sprites/neutral_cat.png")

    # if cat is happy enough, win
    if cat_happines >= cat_happy:
        cat.texture = preload("res://mini_games/catplay/sprites/happy_cat.png")
        print("The cat is super happy!")
        _win_game()
