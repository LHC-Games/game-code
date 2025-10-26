extends Area2D


@export var start_time = 0.1
@export var duration_activating = 1.0
@export var duration_disable = 1.5
@export var duration_activated = 2.0


func _on_body_entered(_body: Node2D) -> void:
	Autoload.needs_to_die = true


func _ready() -> void:
	$CollisionShape2D.disabled = true
	$AnimatedSprite2D.play("inactive")
	$Start.wait_time = start_time
	$Active.wait_time = duration_activating
	$Inactive.wait_time = duration_activated
	$Activating.wait_time = duration_disable
	$Start.start()


func _on_start_timeout() -> void:
	$Inactive.start()


func _on_active_timeout() -> void:
	$CollisionShape2D.disabled = false
	$AnimatedSprite2D.play("active")
	$Inactive.start()


func _on_inactive_timeout() -> void:
	$CollisionShape2D.disabled = true
	$AnimatedSprite2D.play("inactive")
	$Activating.start()


func _on_activating_timeout() -> void:
	$CollisionShape2D.disabled = true
	$AnimatedSprite2D.play("activating")
	$Active.start()
