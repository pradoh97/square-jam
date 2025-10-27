extends Node2D
class_name LevelSection

func connect_hazards_to_beat(blacks_duration: float, blacks_timer: Timer):
	for hazard: Hazard in $Hazards.get_children():
		hazard.blacks_duration = blacks_duration
		blacks_timer.timeout.connect(hazard._on_blacks_timeout)
		hazard.set_timers()

func register_checkpoints(player: Player):
	for check_point: CheckPoint in $Checkpoints.get_children():
		check_point.body_entered.connect(func(_body): player.respawn_position = check_point.global_position)
