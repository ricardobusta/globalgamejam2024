extends Node3D

@export var angle_offset: float = 0

const rot_speed: float = deg_to_rad(180)

var angle: float = 0;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    angle = deg_to_rad(angle_offset)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    angle += rot_speed * delta
    rotate_object_local(Vector3(0,1,0), delta * sin(angle))
    position.y += cos(angle) * delta
