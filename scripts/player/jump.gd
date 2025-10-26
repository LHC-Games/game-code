extends Node2D

@onready var player := get_parent()

@export var jump_velocity = -400.0

func _physics_process(_delta: float) -> void:
	if not player.die.is_die and player.is_on_floor() and Input.is_action_just_pressed("up"):
			player.velocity.y = jump_velocity
			$JumpSound.play()
