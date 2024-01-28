extends MinigameController

@onready var eyes: Node3D = $Eyes
@onready var hat: Node3D = $Hat
@onready var nose: Node3D = $Nose
@onready var mouth: Node3D = $Mouth
@onready var clickable: ClickableArea3D = $ClickableArea3D
@onready var audio_player: AudioStreamPlayer = $AudioStreamPlayer

const hehehe_sound: AudioStream = preload("res://mini_games/clown/sfx/hehehe.wav")
const muahaha_sound: AudioStream = preload("res://mini_games/clown/sfx/muahaha.wav")
const select_sound: AudioStream = preload("res://mini_games/clown/sfx/select.wav")

const speed: float = deg_to_rad(140)
const angle_to_section: float = 2.0/PI

var clicked: int = 0
var rotating: Node3D = null

func _ready() -> void:
    clickable.clicked.connect(_on_click)

    hat.rotate_y(randf_range(0, PI*2))
    rotating = hat
    remove_child(eyes)
    remove_child(nose)
    remove_child(mouth)

func timeout() -> void:
    pass

func _process(delta: float) -> void:
    if rotating:
        rotating.rotate_y(speed*delta)

    if _paused():
        return

    if(clicked >= 4):
        _win_game()

func _on_click(_node: Node3D) -> void:
    if _paused() or !rotating:
        return
    rotating.rotation.y = _stop_angle(rotating.rotation.y)
    if(clicked < 1):
        rotating = eyes
        add_child(rotating)
        rotating.rotate_y(randf_range(0, PI*2))
        audio_player.stream = select_sound
        audio_player.play()
    elif(clicked < 2):
        rotating = nose
        add_child(rotating)
        rotating.rotate_y(randf_range(0, PI*2))
        audio_player.stream = select_sound
        audio_player.play()
    elif(clicked < 3):
        rotating = mouth
        add_child(rotating)
        rotating.rotate_y(randf_range(0, PI*2))
        audio_player.stream = select_sound
        audio_player.play()
    elif(clicked < 4):
        rotating = null
        if is_zero_approx(hat.rotation.y) and \
        is_zero_approx(eyes.rotation.y) and \
        is_zero_approx(nose.rotation.y) and \
        is_zero_approx(mouth.rotation.y):
            audio_player.stream = hehehe_sound
            _win_game()
        else:
            audio_player.stream = muahaha_sound
            _lose_game()
        audio_player.play()
    clicked+=1

func _stop_angle(angle: float) -> float:
    var rot: float = round(angle * angle_to_section)
    return rot / angle_to_section


