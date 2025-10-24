extends Node2D
class_name Level
# Nice values: 50, 70, 110
@export var bpm: float = 70.0
@export var movement_step: int = 64
@export var screen_left_limit: int = -576
@export var screen_right_limit: int = 1125
var blacks_duration: float = 0.0


func _ready():
	$Player/Camera2D.limit_enabled = true
	$Player/Camera2D.limit_left = screen_left_limit
	$Player/Camera2D.limit_right = screen_right_limit
	var seconds_in_minute = 60
	blacks_duration = seconds_in_minute/bpm
	$Blacks.wait_time = blacks_duration

	$UI/CompassFeedback.set_blacks_duration(blacks_duration)
	$Blacks.timeout.connect($UI/CompassFeedback._on_blacks_timeout)

	$Grid.draw(movement_step)

	for hazard: Hazard in $Hazards.get_children():
		hazard.blacks_duration = blacks_duration
		$Blacks.timeout.connect(hazard._on_blacks_timeout)
		hazard.set_timers()
	for check_point: CheckPoint in $CheckPoints.get_children():
		check_point.body_entered.connect(func(_body): $Player.respawn_position = check_point.global_position)
