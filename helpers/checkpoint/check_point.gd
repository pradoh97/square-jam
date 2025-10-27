extends Area2D
class_name CheckPoint

func _on_body_entered(_body):
	$AnimationPlayer.play("collected")
	$AnimationPlayer.animation_finished.connect(queue_free.unbind(1))
