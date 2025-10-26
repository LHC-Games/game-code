extends Area2D


@export var start_time = 0.1
@export var active_time = 3.0
@export var inactive_time = 1.0


func _on_body_entered(body: Node2D) -> void:
	Autoload.needs_to_die = true


func _ready() -> void:
	$CollisionShape2D.disabled = false
	$AnimatedSprite2D.play("active")
	$Start.wait_time = start_time
	$Active.wait_time = active_time
	$Inactive.wait_time = inactive_time
	$Start.start()


func _on_start_timeout() -> void:
	$Inactive.start()


func _on_active_timeout() -> void:
	$CollisionShape2D.disabled = true
	$AnimatedSprite2D.play("inactive")
	$Inactive.start()


func _on_inactive_timeout() -> void:
	$CollisionShape2D.disabled = false
	$AnimatedSprite2D.play("active")
	$Active.start()
