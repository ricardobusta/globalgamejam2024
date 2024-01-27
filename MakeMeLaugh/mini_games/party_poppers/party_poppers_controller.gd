extends MinigameController

@onready var party_popper_01 = $"Party_popper_01/Party_popper_012D"

func _ready():
    pass # Replace with function body.

func _process(delta):
    # if click on popper, it pops
        print("plim")
        party_popper_01.texture = preload("res://mini_games/party_poppers/sprites/opened_popper_01.png")
