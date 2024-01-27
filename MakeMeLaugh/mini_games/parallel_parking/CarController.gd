extends Node2D
class_name CarController

const rotation_speed: float = deg_to_rad(125)
var velocity: float = 0.0
const max_velocity: float = 100
const friction: float = 200
const acceleration: float = 300
const wheel_rotation: float = deg_to_rad(25)
const position_threshold:float = 10
const angle_threshold:float = 0.15
var is_car_crashed: bool = false
var is_car_on: bool = false

@onready var top_left_wheel: Node2D = $TopLeftWheel
@onready var top_right_wheel: Node2D = $TopRightWheel
@onready var area_2d: Area2D = $"."
@onready var audio_stream: AudioStreamPlayer2D = $"../AudioStreamPlayer"
@onready var parking_spot:Node2D = $"../ParkingSpot"

signal car_crashed
signal car_parked

func _ready() -> void:
    area_2d.area_entered.connect(_on_area_entered)

func _process(delta: float) -> void:
    if is_car_crashed or !is_car_on:
        return
    var wheel_current_rotation: float = 0
    var up_or_down: bool = false

    if Input.is_action_pressed("right"):
        self.rotation += rotation_speed * delta * (velocity/max_velocity)
        wheel_current_rotation += wheel_rotation
    if Input.is_action_pressed("left"):
        self.rotation -= rotation_speed * delta * (velocity/max_velocity)
        wheel_current_rotation += -wheel_rotation
    if Input.is_action_pressed("down"):
        velocity -= acceleration * delta
        up_or_down = true
    if Input.is_action_pressed("up"):
        velocity += acceleration * delta
        up_or_down = true

    if !up_or_down:
        if velocity > 0:
            velocity = max( (velocity - friction * delta), 0)
        if velocity < 0:
            velocity = min( (velocity + friction * delta), 0)

    velocity = clamp(velocity, -max_velocity, max_velocity)

    top_left_wheel.rotation = wheel_current_rotation
    top_right_wheel.rotation = wheel_current_rotation

    self.position += self.transform.basis_xform(Vector2.UP) * velocity * delta

    var parking_distance: float = abs(self.position.x - parking_spot.position.x)
    var parking_angle: float = abs(self.rotation)
    if parking_distance < position_threshold and parking_angle < angle_threshold:
        car_parked.emit()

func _on_area_entered(_area: Area2D) -> void:
    audio_stream.play()
    is_car_crashed = true
    car_crashed.emit()

