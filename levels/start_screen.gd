extends Node2D

@export var level_scene: PackedScene

func _on_button_pressed():
	$Tutorial/CenterContainer/VBoxContainer/CenterContainer/Button.disabled = true
	var tween: Tween = create_tween()
	tween.set_parallel()
	tween.tween_property($Tutorial/CenterContainer, "modulate", Color.TRANSPARENT, 0.5)
	tween.tween_property($Tutorial/ColorRect, "modulate", Color.TRANSPARENT, 0.5)
	tween.finished.connect(func(): get_tree().change_scene_to_packed(level_scene))
