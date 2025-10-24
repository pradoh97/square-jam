extends Node2D

func _ready():
	$Looper.start()
	$Music.play()

func _on_looper_timeout():
	if $Music.is_playing():
		$Music2.play()
	else:
		$Music.play()
