extends AnimatedSprite2D

@onready var player := get_parent()

func _physics_process(_delta: float) -> void:
	if player.wall_jump.is_wall_sliding:
		hide()
		player.wall_slide.show()
	else:
		player.wall_slide.hide()
		show()
	
	if player.velocity.x < 0:
		flip_h = true
	elif player.velocity.x > 0:
		flip_h = false
	if player.dash.is_dashing:
		play("dash")
	elif not player.is_on_floor():
		if player.wall_jump.is_wall_sliding:
			pass
			#flip_h = false
			#play("wall_slide")
		else:
			play("jump")
	else:
		if not is_zero_approx(player.velocity.x):
			play("walk")
		else:
			play("idle")
