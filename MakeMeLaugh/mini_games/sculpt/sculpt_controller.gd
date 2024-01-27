extends MinigameController

@onready var clickable_area: ClickableArea3D = $Container/ClickableArea3D
@onready var blocks: Node3D = $Container/Blocks

func _ready() -> void:
    clickable_area.clicked.connect(_clicked)

func timeout() -> void:
    pass

func _clicked(_node: Node3D) -> void:
    if _paused():
        return

    if blocks.get_child_count() > 0:
        var child = blocks.get_child(0)
        blocks.remove_child(child)
        child.queue_free()
        if blocks.get_child_count() == 0:
            _win_game()
