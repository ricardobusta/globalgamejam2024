extends Node

const max_health: int = 5
const pregame_action_time: float = 1
const postgame_action_time: float = 1

var scenes: Array = []
var health_icons: Array = []

var active_game: MinigameController = null
var minigame_index: int = 0
var current_health: int = max_health
var current_time: float = 0
var game_running: bool = false
var victory_count: int = 0

@onready var game_presentation: Node = $GamePresentation
@onready var health_container: BoxContainer = $GameplayUI/HBoxContainer
@onready var health_template: TextureRect = $GameplayUI/HBoxContainer/TextureRect
@onready var time_bar: ProgressBar = $GameplayUI/ProgressBar
@onready var quit_button: Button = $GameplayUI/QuitButton
@onready var action_label: Label = $GamePresentation/ActionLabel
@onready var victory_count_label: Label = $GameplayUI/VictoryCountLabel

func _ready() -> void:
    health_container.remove_child(health_template)
    for i: int in range(0, max_health):
        health_icons.append(health_template.duplicate());
        var node: Node = health_icons[i]
        health_container.add_child(node)

    scenes.append(load("res://mini_games/catplay/catplay.tscn"))
    scenes.append(load("res://mini_games/z_test_buttons/test_buttons.tscn"))
    scenes.append(load("res://mini_games/party_poppers/party_poppers.tscn"))

    scenes.shuffle()

    remove_child(game_presentation)

    _set_minigame(minigame_index)

    victory_count_label.text = "%d" % victory_count

    quit_button.pressed.connect(_go_to_title)

func _set_minigame(index: int) -> void:
    if active_game:
        remove_child(active_game)
        active_game.queue_free()
    var scene: PackedScene = scenes[index]
    active_game = scene.instantiate()
    active_game.game_won_signal.connect(_on_game_won)
    active_game.game_lost_signal.connect(_on_game_lost)
    current_time = active_game.time
    time_bar.max_value = active_game.time
    time_bar.value = active_game.time
    add_child(active_game)
    action_label.text = active_game.action

    add_child(game_presentation)

    get_tree().create_timer(pregame_action_time).timeout.connect(_on_minigame_start)

func _on_minigame_start() -> void:
    game_running = true
    active_game.start()
    remove_child(game_presentation)

func _on_game_won() -> void:
    print("Won %s" % active_game.action)
    victory_count += 1
    victory_count_label.text = "%d" % victory_count
    _update_health_bar()
    get_tree().create_timer(postgame_action_time).timeout.connect(_play_next_minigame)

func _on_game_lost() -> void:
    print("Lost!")
    current_health -= 1

    if current_health == 0:
        _go_to_title()

    _update_health_bar()
    get_tree().create_timer(postgame_action_time).timeout.connect(_play_next_minigame)

func _update_health_bar() -> void:
    for i: int in range(0, max_health):
        var health_icon: Node = health_icons[i]
        if i >= current_health:
            if health_icon.get_parent():
                health_container.remove_child(health_icon)
        else:
            if !health_icon.get_parent():
                health_container.add_child(health_icon)

func _play_next_minigame() -> void:
    minigame_index += 1
    minigame_index %= scenes.size()
    _set_minigame(minigame_index)

func _process(delta: float) -> void:
    if game_running:
        current_time -= delta
        time_bar.value = current_time
        if current_time <= 0:
            active_game.game_over = true
            active_game.timeout()
            game_running = false
            _on_game_lost()

func _go_to_title() -> void:
    get_tree().change_scene_to_file("res://meta/title_screen.tscn")
