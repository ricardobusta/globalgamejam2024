extends Area2D

class_name ClickableArea2D

signal clicked

func _ready() -> void:
    input_event.connect(_on_input_event)

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
    if event is InputEventMouseButton:
        var button: InputEventMouseButton = event
        if button.button_index == MOUSE_BUTTON_LEFT and button.pressed:
            clicked.emit(get_name())
