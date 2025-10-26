extends Node2D

@onready var player := get_parent()

@export var move_speed = 300.0
@export var acceleration = 1500.0
@export var friction = 3000.0


func _physics_process(delta: float) -> void:
	if not player.grapple.launched and not player.die.is_die:
		var direction = Input.get_axis("left", "right")
		if direction:
			player.velocity.x = move_toward(player.velocity.x, direction*move_speed, acceleration*delta)
		elif not Autoload.in_the_wind:
			player.velocity.x = move_toward(player.velocity.x, 0, friction*delta)
		
		if Autoload.in_the_wind:
			if Autoload.wind_direction == Autoload.direction_enum.LEFT:
				player.velocity.x = move_toward(player.velocity.x, -300.0, 2600*delta)
			else:
				player.velocity.x = move_toward(player.velocity.x, 300.0, 2600*delta)
	
