extends Area2D
class_name Hazard

@export var movement_step = 64
@export var forgiveness = 0.1
@export var active = false
@export var downwards_movement = false
@export var required_beats: float = 1.0

var movement_direction = 1
var blacks_duration = 1.0
var current_beat = 0

func _ready():
	if downwards_movement:
		movement_direction = -1
	$ForgivenessAttackTimer.timeout.connect(func(): $CollisionShape2D.set_deferred("disabled", false))
	$ForgivenessReleaseTimer.timeout.connect(func(): $CollisionShape2D.set_deferred("disabled", true))
	body_entered.connect(_on_body_entered)

	if active:
		$CollisionShape2D.set_deferred("disabled", false)
	else:
		$CollisionShape2D.set_deferred("disabled", true)
	$CollisionShape2D.set_deferred("disabled", false)

func move():
	active = not active
	var tween: Tween = create_tween()
	if active:
		tween.set_ease(Tween.EASE_OUT)
		tween.set_trans(Tween.TRANS_QUINT)
		tween.tween_property(self, "global_position:y", global_position.y - movement_direction*movement_step, blacks_duration*forgiveness)
		$ForgivenessAttackTimer.start()
		$CollisionShape2D.set_deferred("disabled", true)
	elif not active:
		tween.set_ease(Tween.EASE_OUT)
		tween.set_trans(Tween.TRANS_QUINT)
		tween.tween_property(self, "global_position:y", global_position.y + movement_direction*movement_step, blacks_duration*forgiveness)

func set_timers():
	$ForgivenessAttackTimer.wait_time = blacks_duration*forgiveness
	$ForgivenessAttackTimer.one_shot = true
	$ForgivenessReleaseTimer.wait_time = required_beats*blacks_duration - blacks_duration*forgiveness*required_beats
	$ForgivenessReleaseTimer.one_shot = true

func _on_blacks_timeout():
	current_beat += 1
	if current_beat == required_beats:
		current_beat = 0
		move()
		if active:
			$ForgivenessReleaseTimer.start()

func _on_body_entered(body):
	(body as Player).respawn()
