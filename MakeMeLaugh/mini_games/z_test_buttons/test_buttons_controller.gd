extends MinigameController

@onready var win_button: ClickableArea2D = $WinButton
@onready var lose_button: ClickableArea2D = $LoseButton

func _ready() -> void:
    win_button.clicked.connect(_on_button_clicked)
    lose_button.clicked.connect(_on_button_clicked)

func _on_button_clicked(name: String) -> void:
    if name == "WinButton":
        _win_game()
    else:
        _lose_game()