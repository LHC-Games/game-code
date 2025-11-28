extends Node2D

@onready var player := get_parent()

var force = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var fast_fall_multiplier: float = 1.35

func _physics_process(delta: float) -> void:
	if not player.is_on_floor():
		var current_gravity = force
		
		if player.velocity.y > 0:
			current_gravity = force * fast_fall_multiplier
			
		player.velocity.y += current_gravity * delta
		$LandingSound.play()
