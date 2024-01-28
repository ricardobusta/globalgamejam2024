extends MinigameController

@onready var popper1: ClickableArea2D = $Popper1
@onready var popper_open1: PartyPopper = $PopperOpen1

@onready var popper2: ClickableArea2D = $Popper2
@onready var popper_open2: PartyPopper = $PopperOpen2

@onready var popper3: ClickableArea2D = $Popper3
@onready var popper_open3: PartyPopper = $PopperOpen3

@onready var audio_player: AudioStreamPlayer = $AudioStreamPlayer

var count: int = 0

func _ready() -> void:
    popper1.clicked.connect(_on_popper_clicked)
    popper_open1.hide()
    popper2.clicked.connect(_on_popper_clicked)
    popper3.clicked.connect(_on_popper_clicked)

func _on_popper_clicked(popper: ClickableArea2D) -> void:
    if _paused():
        return

    count+=1

    remove_child(popper)
    popper.queue_free()

    audio_player.play()

    if popper == popper1:
        popper_open1.show()
        popper_open1.play()
    elif popper == popper2:
        popper_open2.show()
        popper_open2.play()
    elif popper == popper3:
        popper_open3.show()
        popper_open3.play()

    if count >= 3:
        _win_game()

func timeout() -> void:
    pass
