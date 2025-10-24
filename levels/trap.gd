extends Area2D
@export var movement_step = 64
@export var forgiveness = 0.1
@export var active = false
@export var use_tween = false
@export var compass_duration = 1

var blacks_duration = 1.0
var last_compass_played = 0

func _ready():
	blacks_duration = 60/get_parent().get_parent().bpm
	$ForgivenessAttackTimer.wait_time = blacks_duration*forgiveness
	$ForgivenessAttackTimer.one_shot = true
	$ForgivenessAttackTimer.timeout.connect(func(): $CollisionShape2D.set_deferred("disabled", false))
	$ForgivenessReleaseTimer.wait_time = compass_duration*blacks_duration - blacks_duration*forgiveness*compass_duration
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
			tween.tween_property(self, "global_position:y", global_position.y - movement_step, 0.5)
			tween.finished.connect(func(): $CollisionShape2D.set_deferred("disabled", false))
		$ForgivenessAttackTimer.start()
		$CollisionShape2D.set_deferred("disabled", true)
		global_position.y -= movement_step
	elif not active:
		if use_tween:
			tween.set_ease(Tween.EASE_OUT)
			tween.set_trans(Tween.TRANS_QUINT)
			tween.tween_property(self, "global_position:y", global_position.y + movement_step, 0.5)
			$CollisionShape2D.set_deferred("disabled", true)
		global_position.y += movement_step


func _on_blacks_timeout():
	last_compass_played += 1
	if last_compass_played == compass_duration:
		last_compass_played = 0
		move()
		if active:
			$ForgivenessReleaseTimer.start()

func _on_body_entered(body):
	(body as Player).respawn()
