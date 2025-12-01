extends Node2D

@onready var player := get_parent()

var is_die = false

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("respawn") and not is_die:
		Autoload.needs_to_die = true
	if not is_die:
		if Autoload.needs_to_die:
			Autoload.needs_to_die = false
			die()
		for i in player.get_slide_collision_count():
			var collision = player.get_slide_collision(i)
			if collision:
				var collider_rid = collision.get_collider_rid()
				var layer_mask = PhysicsServer2D.body_get_collision_layer(collider_rid)
				if layer_mask == 4:
					die()
					break


func die() -> void:
	
	if is_die:
		return
		
	if Autoload.in_software:
		$DeathSound.play()
		player.collision_shape.set_deferred("disabled", true)
		#player.collision_shape.disabled = true
		player.grapple.die_retract()
		is_die = true
		player.modulate = Color(10000, 10000, 10000, 0.5)
		player.velocity.x = sign(player.velocity.x) * 15
		player.velocity.y = 0.0
		player.gravity.force = -100
		await get_tree().create_timer(0.8).timeout
		player.velocity.x = 0.0
		player.velocity.y = 0.0
		player.gravity.force = ProjectSettings.get_setting("physics/2d/default_gravity")
		player.global_position = Autoload.checkpoint
		get_tree().call_group("mobs", "queue_free")
		
		player.collision_shape.set_deferred("disabled", false)
		
		await get_tree().create_timer(0.1).timeout
		
		Autoload.needs_to_die = false
		#player.collision_shape.disabled = false
		
		is_die = false
		player.modulate = Color(10000, 10000, 10000, 1)
	else:	
		$DeathSound.play()
		#player.collision_shape.disabled = true
		player.collision_shape.set_deferred("disabled", true)
		player.grapple.die_retract()
		is_die = true
		player.modulate = Color(0.75, 0.75, 0.75, 0.5)
		player.velocity.x = sign(player.velocity.x) * 15
		player.velocity.y = 0.0
		player.gravity.force = -100
		await get_tree().create_timer(0.8).timeout
		player.velocity.x = 0.0
		player.velocity.y = 0.0
		player.gravity.force = ProjectSettings.get_setting("physics/2d/default_gravity")
		player.global_position = Autoload.checkpoint
		
		#player.collision_shape.disabled = false
		player.collision_shape.set_deferred("disabled", false)
		await get_tree().create_timer(0.1).timeout
		Autoload.needs_to_die = false
		
		is_die = false
		player.modulate = Color(1, 1, 1, 1)
