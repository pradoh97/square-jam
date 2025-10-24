extends Timer

func _ready():
	wait_time = 60/get_parent().bpm
	timeout.emit()
