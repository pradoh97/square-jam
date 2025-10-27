extends Node2D
class_name CompassFeedback

var beat_count = 0
var blacks_duration: float = 0

func _on_blacks_timeout():
	beat_count += 1
	var blink_tween: Tween = create_tween()
	var movement_tween: Tween = create_tween()
	var blink_tween_duration = 0.2
	var transition_color = Color(1.0, 1.0, 1.0, 0.5)
	var original_color = modulate
	var target_position: Vector2 = $Moving.global_position + Vector2(0, 50)

	if beat_count == 4:
		beat_count = 0
		transition_color = Color(0.576, 0.42, 0.612, 0.835)
	if beat_count % 2:
		target_position = $Moving.global_position - Vector2(0, 50)
	movement_tween.tween_property($Moving, "global_position", target_position, blacks_duration)
	movement_tween.finished.connect(func(): $Moving.global_position = target_position)

	blink_tween.tween_property(self, "modulate", transition_color, blink_tween_duration)
	blink_tween.tween_property(self, "modulate", original_color, blink_tween_duration)

func set_blacks_duration(duration: float):
	blacks_duration = duration
