extends Node2D

@export var song: AudioStream
@export var loop_time: float = 60

func _ready():
	$Music.stream = song
	$Music2.stream = song
	$Looper.wait_time = loop_time
	$Looper.one_shot = true

	$Looper.start()
	$Music.play()

func _on_looper_timeout():
	if $Music.is_playing():
		$Music2.play()
	else:
		$Music.play()
	$Looper.start()
