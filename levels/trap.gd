extends Area2D
@export var movement_step = 64

@export var active = false

func _ready():
	body_entered.connect(_on_body_entered)
	if active:
		$CollisionShape2D.set_deferred("disabled", false)
	else:
		$CollisionShape2D.set_deferred("disabled", true)

func move():
	active = not active
	var tween = create_tween()
	if active:
		tween.set_ease(Tween.EASE_OUT)
		tween.set_trans(Tween.TRANS_QUINT)
		tween.tween_property(self, "global_position:y", global_position.y - movement_step, 0.5)
		tween.finished.connect(func(): $CollisionShape2D.set_deferred("disabled", false))
	else:
		tween.set_ease(Tween.EASE_OUT)
		tween.set_trans(Tween.TRANS_QUINT)
		tween.tween_property(self, "global_position:y", global_position.y + movement_step, 0.5)
		$CollisionShape2D.set_deferred("disabled", true)

func _on_whites_timeout():
	move()

func _on_blacks_timeout():
	move()

func _on_body_entered(body):
	(body as Player).respawn()
