extends CharacterBody2D

@export var speed = 700.0
@export var difficulty = 0.0
var target: Vector2


func _ready() -> void:
	target = Autoload.player.global_position
	var direction = (target - global_position).normalized()
	velocity = direction * (speed + difficulty)


func _physics_process(delta):
	move_and_slide()


func _on_timer_timeout() -> void:
	queue_free()
