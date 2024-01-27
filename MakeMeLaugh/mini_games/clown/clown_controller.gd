extends MinigameController

@onready var eyes: Node3D = $Eyes
@onready var hat: Node3D = $Hat
@onready var nose: Node3D = $Nose
@onready var mouth: Node3D = $Mouth

const speed: float = deg_to_rad(100)

func timeout() -> void:
    pass

func _process(delta: float) -> void:
    hat.rotate_y(speed*delta)
    eyes.rotate_y(-speed*delta)
    nose.rotate_y(speed*delta)
    mouth.rotate_y(-speed*delta)
