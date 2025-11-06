extends CharacterBody2D

@export var speed = 200.0
@export var difficulty = 0.0
var target: Vector2


func _physics_process(_delta):
	target = Autoload.player.global_position
	var direction = (target - global_position).normalized()
	velocity = direction * (speed + difficulty)
	move_and_slide()


func _on_timeout_timeout() -> void:
	queue_free()
