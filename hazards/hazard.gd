extends Area2D
class_name Hazard

@export var movement_step = 64
@export var forgiveness = 0.1
@export var active = false
@export var use_tween = true
@export var required_beats = 1

var blacks_duration = 1.0
var current_beat = 0

func _ready():
	$ForgivenessAttackTimer.wait_time = blacks_duration*forgiveness
	$ForgivenessAttackTimer.one_shot = true
	$ForgivenessAttackTimer.timeout.connect(func(): $CollisionShape2D.set_deferred("disabled", false))
	$ForgivenessReleaseTimer.wait_time = required_beats*blacks_duration - blacks_duration*forgiveness*required_beats
	$ForgivenessReleaseTimer.one_shot = true
	$ForgivenessReleaseTimer.timeout.connect(func(): $CollisionShape2D.set_deferred("disabled", true))
	body_entered.connect(_on_body_entered)
	if active:
		$CollisionShape2D.set_deferred("disabled", false)
	else:
		$CollisionShape2D.set_deferred("disabled", true)
	$CollisionShape2D.set_deferred("disabled", false)

func move():
	active = not active
	var tween
	if use_tween:
		tween = create_tween()
	if active:
		if use_tween:
			tween.set_ease(Tween.EASE_OUT)
			tween.set_trans(Tween.TRANS_QUINT)
			tween.tween_property(self, "global_position:y", global_position.y - movement_step, blacks_duration*0.25)
		else:
			global_position.y -= movement_step
		$ForgivenessAttackTimer.start()
		$CollisionShape2D.set_deferred("disabled", true)
	elif not active:
		if use_tween:
			tween.set_ease(Tween.EASE_OUT)
			tween.set_trans(Tween.TRANS_QUINT)
			tween.tween_property(self, "global_position:y", global_position.y + movement_step, blacks_duration*0.25)
		else:
			global_position.y += movement_step


func _on_blacks_timeout():
	current_beat += 1
	if current_beat == required_beats:
		current_beat = 0
		move()
		if active:
			$ForgivenessReleaseTimer.start()

func _on_body_entered(body):
	(body as Player).respawn()
