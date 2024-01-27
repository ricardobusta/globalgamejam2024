extends MinigameController

@onready var car:CarController = $CarArea2D

func _ready():
    car.car_crashed.connect(_car_crashed)
    car.car_parked.connect(_car_parked)

func _car_crashed():
    _lose_game()

func _car_parked():
    _win_game()

func timeout() -> void:
    pass

func _process(_delta: float) -> void:
    if _paused():
        car.is_car_on = false
        return
    car.is_car_on = true
