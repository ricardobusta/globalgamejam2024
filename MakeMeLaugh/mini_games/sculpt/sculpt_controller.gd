extends MinigameController

@onready var clickable_area: ClickableArea3D = $Container/ClickableArea3D
@onready var blocks: Node3D = $Container/Blocks
@onready var audio_stream: AudioStreamPlayer = $AudioStreamPlayer
@onready var directional_light: Node3D = $DirectionalLight3D
@onready var spot_light: Node3D = $SpotLight3D

const break_sound: AudioStream = preload("res://mini_games/sculpt/sfx/break.wav")
const tada_sound: AudioStream = preload("res://mini_games/sculpt/sfx/tada.wav")

func _ready() -> void:
    clickable_area.clicked.connect(_clicked)

func timeout() -> void:
    pass

func _clicked(_node: Node3D) -> void:
    if _paused():
        return

    if blocks.get_child_count() > 0:
        var child: Node = blocks.get_child(0)
        blocks.remove_child(child)
        child.queue_free()
        audio_stream.stream = break_sound
        audio_stream.play()
        if blocks.get_child_count() == 0:
            directional_light.hide()
            spot_light.show()
            var tween: Tween = get_tree().create_tween()
            tween.tween_property($Camera3D, "position", Vector3(0.291,0.802,1.661), 0.3)
            var tween2: Tween = get_tree().create_tween()
            tween2.tween_property($Camera3D, "rotation", Vector3(deg_to_rad(-14.9),deg_to_rad(6.4),deg_to_rad(-0.4)), 0.3)
            get_tree().create_timer(0.5).timeout.connect(_play_tada)
            _win_game()

func _play_tada() -> void:
        audio_stream.stream = tada_sound
        audio_stream.play()
