extends CharacterBody2D
class_name Player

@export var use_tween = false
var movement_step = 64
var initial_pos: Vector2
var movement_ongoing = false
var movement_tween: Tween

func _ready():
	initial_pos = global_position

func _input(event):
	if event.is_action_pressed("move") and use_tween:
		if movement_tween and movement_tween.is_running():
			movement_tween.pause()
			movement_tween.custom_step(1.1)
		movement_tween = create_tween()
		movement_tween.set_ease(Tween.EASE_OUT)
		movement_tween.set_trans(Tween.TRANS_QUINT)
		movement_tween.tween_property(self, "global_position:x", global_position.x + movement_step, 0.5)
		movement_tween.play()
	if event.is_action_pressed("move") and not use_tween:
		global_position.x += movement_step

func respawn():
	var particles = $CPUParticles2D.duplicate()
	get_parent().add_child(particles)
	particles.global_position = $CPUParticles2D.global_position
	if use_tween:
		movement_tween.kill()
	global_position = initial_pos
	particles.emitting = true
