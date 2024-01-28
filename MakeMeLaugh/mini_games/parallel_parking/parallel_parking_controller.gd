extends MinigameController

@onready var car:CarController = $CarArea2D

@onready var car2: Node2D = $Car2
@onready var car3: Node2D = $Car3
@onready var car4: Node2D = $Car4
@onready var car5: Node2D = $Car5
@onready var car6: Node2D = $Car6

func _ready():
    car.car_crashed.connect(_car_crashed)
    car.car_parked.connect(_car_parked)

func _car_crashed():
    _lose_game()

func _car_parked():
    _move_car(car2, 1000)
    _move_car(car3, -1000)
    _move_car(car4, -1000)
    _move_car(car5, 1000)
    _move_car(car6, 1000)
    _win_game()

func timeout() -> void:
    pass

func _process(_delta: float) -> void:
    if _paused():
        car.is_car_on = false
        return
    car.is_car_on = true

func _move_car(c: Node2D, a: float) -> void:
    var tween = get_tree().create_tween()
    tween.tween_property(c, "position:y", c.position.y+a, 1.0)
