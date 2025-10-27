extends CharacterBody2D
class_name Player

var movement_step = 64
var respawn_position: Vector2
var movement_ongoing = false
var distance_travelled: float = 0
var movement_start_position: float = 0
var is_moving: bool = false

func _ready():
	respawn_position = global_position
	set_physics_process(false)
	

func _physics_process(delta):
	if Input.is_action_just_pressed("move") and not is_moving:
		is_moving = true
		movement_start_position = global_position.x
		velocity.x = movement_step * delta * 1000
	move_and_slide()
	distance_travelled = global_position.x - movement_start_position
	if (is_zero_approx(movement_step - distance_travelled) or distance_travelled > movement_step) and is_moving:
		velocity.x = 0
		global_position.x = movement_start_position + movement_step
		is_moving = false

func respawn():
	is_moving = false
	distance_travelled = 0
	movement_start_position = 0
	velocity.x = 0
	var particles = $CPUParticles2D.duplicate()
	get_parent().add_child(particles)
	particles.global_position = $CPUParticles2D.global_position
	global_position = respawn_position
	particles.emitting = true

func _on_blacks_timeout():
	set_physics_process(true)
