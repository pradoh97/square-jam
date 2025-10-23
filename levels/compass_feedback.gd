extends Line2D

var compass_count = 0


func _on_blacks_timeout():
	compass_count += 1
	var tween: Tween = create_tween()
	var tween_duration = 0.2
	var transition_color = Color(1.0, 1.0, 1.0, 0.5)
	var original_color = modulate
	if compass_count == 4:
		compass_count = 0
		transition_color = Color(0.576, 0.42, 0.612, 0.835)
	tween.tween_property(self, "modulate", transition_color, tween_duration)
	tween.tween_property(self, "modulate", original_color, tween_duration)
