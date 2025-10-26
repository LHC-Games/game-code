extends AnimatedSprite2D

@onready var player := get_parent()

func _physics_process(_delta: float) -> void:
	if player.velocity.x < 0:
		flip_h = true
	elif player.velocity.x > 0:
		flip_h = false
	if player.dash.is_dashing:
		play("dash")
	elif not player.is_on_floor():
		if player.wall_jump.is_wall_sliding:
			play("wall_slide")
		else:
			play("jump")
	else:
		if not is_zero_approx(player.velocity.x):
			play("walk")
		else:
			play("idle")
