extends Node2D
class_name Grid

@export var compensation_line = 1

func draw(movement_step = 0):
	var horizontal_lines = get_viewport_rect().size.x / movement_step + compensation_line
	var vertical_lines = get_viewport_rect().size.y / movement_step + compensation_line
	for line in range(0, horizontal_lines):
		var new_line: Line2D = $HorizontalLine.duplicate()
		add_child(new_line)
		new_line.visible = true
		new_line.global_position.x += movement_step*line

	for line in range(0, vertical_lines):
		var new_line: Line2D = $VerticalLine.duplicate()
		add_child(new_line)
		new_line.visible = true
		new_line.global_position.y += movement_step*line
