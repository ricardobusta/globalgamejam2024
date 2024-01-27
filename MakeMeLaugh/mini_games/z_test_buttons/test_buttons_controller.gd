extends MinigameController

@export var win_material: Material
@export var lose_material: Material

@onready var win_button: ClickableArea3D = $WinButton
@onready var lose_button: ClickableArea3D = $LoseButton
@onready var lamp: MeshInstance3D = $Lamp

var game_over: bool = false

func _ready() -> void:
    win_button.clicked.connect(_on_button_clicked)
    lose_button.clicked.connect(_on_button_clicked)

func _on_button_clicked(button: ClickableArea3D) -> void:
    if game_over:
        return

    game_over = true
    if button == win_button:
        lamp.material_override = win_material
        _win_game()
    else:
        lamp.material_override = lose_material
        _lose_game()

func timeout() -> void:
    lamp.material_override = lose_material
    game_over = true
