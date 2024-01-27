extends MinigameController

@onready var win_button: ClickableArea3D = $WinButton
@onready var lose_button: ClickableArea3D = $LoseButton

func _ready() -> void:
    win_button.clicked.connect(_on_button_clicked)
    lose_button.clicked.connect(_on_button_clicked)

func _on_button_clicked(button_name: String) -> void:
    if button_name == "WinButton":
        _win_game()
    else:
        _lose_game()
