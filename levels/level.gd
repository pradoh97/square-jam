extends Node2D
class_name Level
# Nice values: 50, 70, 110
@export var bpm: float = 70.0
@export var movement_step: int = 64
@export var screen_left_limit: int = 0
var blacks_duration: float = 0.0

func _ready():
	$Player/Camera2D.limit_enabled = true
	$Player/Camera2D.limit_left = screen_left_limit
	var seconds_in_minute = 60
	blacks_duration = seconds_in_minute/bpm
	$Blacks.wait_time = blacks_duration

	$UI/CompassFeedback.set_blacks_duration(blacks_duration)
	$Blacks.timeout.connect($UI/CompassFeedback._on_blacks_timeout)

	$Grid.draw(movement_step)

	for section: LevelSection in $LevelSections.get_children():
		section.connect_hazards_to_beat(blacks_duration, $Blacks)
		section.register_checkpoints($Player)

func get_player() -> Player:
	return $Player
