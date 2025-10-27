extends Control
class_name Grid

@export var compensation_line = 1
var beat_count = 0

func draw(movement_step = 0):
	var horizontal_lines = get_viewport_rect().size.y / movement_step + compensation_line
	var vertical_lines = get_viewport_rect().size.x / movement_step + compensation_line
	for line in range(0, vertical_lines):
		var new_line: ColorRect = $VerticalLine.duplicate()
		add_child(new_line)
		new_line.position.x += movement_step*line

	for line in range(0, horizontal_lines):
		var new_line: ColorRect = $HorizontalLine.duplicate()
		add_child(new_line)
		new_line.position.y += movement_step*line

func _on_blacks_timeout():
	beat_count += 1
	var blink_tween: Tween = create_tween()
	var blink_tween_duration = 0.2
	var transition_color = Color(1.0, 1.0, 1.0, 0.153)
	var original_color = modulate

	if beat_count == 4:
		beat_count = 0
		transition_color = Color(0.885, 0.734, 0.971, 0.22)
	blink_tween.tween_property(self, "modulate", transition_color, blink_tween_duration)
	blink_tween.tween_property(self, "modulate", original_color, blink_tween_duration)
