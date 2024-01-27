extends MinigameController

@onready var car:Car = $CarArea2D

# Called when the node enters the scene tree for the first time.
func _ready():
    car.is_car_on = true
    car.car_crashed.connect(_car_crashed)
    car.car_parked.connect(_car_parked)


func _car_crashed():
    car.is_car_on = false
    _lose_game()


func _car_parked():
    car.is_car_on = false
    _win_game()

func timeout() -> void:
    pass
