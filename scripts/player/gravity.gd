extends Node2D

@onready var player := get_parent()

var force = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta: float) -> void:
	if not player.is_on_floor():
		player.velocity.y += force * delta
		$LandingSound.play()
