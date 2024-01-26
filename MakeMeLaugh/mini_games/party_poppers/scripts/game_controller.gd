extends Node

@onready var party_popper_01 = $"../Party_popper_01/Party_popper_012D"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# if click on popper, it pops
	if Input.is_action_pressed("mouse_button_left"):
		print("plim")
		party_popper_01.texture = preload("res://mini_games/party_poppers/sprites/opened_popper_01.png")
