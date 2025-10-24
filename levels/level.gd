extends Node2D
class_name Level
# Nice values: 50, 70, 110
@export var bpm: float = 70.0
@export var movement_step: int = 64
var blacks_duration: float = 0.0

func _ready():
	var seconds_in_minute = 60
	blacks_duration = seconds_in_minute/bpm
	$Blacks.wait_time = blacks_duration

	$CompassFeedback.set_blacks_duration(blacks_duration)
	$Blacks.timeout.connect($CompassFeedback._on_blacks_timeout)

	$Grid.draw(movement_step)

	for hazard: Hazard in $Hazards.get_children():
		hazard.blacks_duration = blacks_duration
		$Blacks.timeout.connect(hazard._on_blacks_timeout)
