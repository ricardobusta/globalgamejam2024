extends MinigameController

@onready var party_popper_01:Popper = $Party_popper_01/Popper01Area2D
@onready var party_popper_01_sprite:Sprite2D = $Party_popper_01/PartyPopperSprite

@onready var party_popper_02:Popper = $Party_popper_02/Popper02Area2D
@onready var party_popper_02_sprite:Sprite2D = $Party_popper_02/PartyPopperSprite

@onready var party_popper_03:Popper = $Party_popper_03/Popper03Area2D
@onready var party_popper_03_sprite:Sprite2D = $Party_popper_03/PartyPopperSprite

func _ready() -> void:
    party_popper_01.clicked.connect(_on_popper_clicked)
    party_popper_02.clicked.connect(_on_popper_clicked)
    party_popper_03.clicked.connect(_on_popper_clicked)

func _on_popper_clicked(popper: Popper) -> void:
    popper.sprite.texture = preload("res://mini_games/party_poppers/sprites/opened_popper_01.png")
    popper.popped = true
    _all_popped()

func _all_popped() -> void:
    if party_popper_01.popped and party_popper_02.popped and party_popper_03.popped:
        _win_game()
