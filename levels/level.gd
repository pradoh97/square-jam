extends Node2D
class_name Level
# Nice values: 50, 70, 110
@export var bpm: float = 70.0
@export var movement_step: int = 64
@export var screen_left_limit: int = 0
var blacks_duration: float = 0.0

func _ready():
	%Grid.visible = true
	$UI.visible = true
	$Player/Camera2D.limit_enabled = true
	$Player/Camera2D.limit_left = screen_left_limit
	var seconds_in_minute = 60
	blacks_duration = seconds_in_minute/bpm
	$Blacks.wait_time = blacks_duration

	$UI/CompassFeedback.set_blacks_duration(blacks_duration)
	$Blacks.timeout.connect($UI/CompassFeedback._on_blacks_timeout)
	$Blacks.timeout.connect($Player._on_blacks_timeout)

	%Grid.draw(movement_step)

	for section: LevelSection in $LevelSections.get_children():
		section.connect_hazards_to_beat(blacks_duration, $Blacks)
		section.register_checkpoints($Player)
	$Timer.timeout.connect(func(): %TimeElapsed.text = str(int(%TimeElapsed.text) + 1))
	$Blacks.timeout.emit()

func get_player() -> Player:
	return $Player


func _on_area_2d_body_entered(_body: Node2D) -> void:
	get_tree().call_deferred("reload_current_scene")
