extends Line2D

var compass_count = 0

func _on_blacks_timeout():
	compass_count += 1
	var blink_tween: Tween = create_tween()
	var movement_tween: Tween = create_tween()
	var target_position: Vector2 = global_position + Vector2(0, 50)
	var blink_tween_duration = 0.2
	var movement_duration: float = 60.0/get_parent().bpm
	var transition_color = Color(1.0, 1.0, 1.0, 0.5)
	var original_color = modulate
	if compass_count == 4:
		compass_count = 0
		transition_color = Color(0.576, 0.42, 0.612, 0.835)
	if compass_count % 2:
		target_position = global_position - Vector2(0, 50)
	movement_tween.tween_property(self, "global_position", target_position, movement_duration)
	movement_tween.finished.connect(func(): global_position = target_position)
	blink_tween.tween_property(self, "modulate", transition_color, blink_tween_duration)
	blink_tween.tween_property(self, "modulate", original_color, blink_tween_duration)
