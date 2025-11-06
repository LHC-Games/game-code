extends Area2D


@export var start_time = 0.1
@export var duration_activated = 3.0
@export var duration_deactivated = 1.0
@export var infinite = false


func _on_body_entered(_body: Node2D) -> void:
	Autoload.needs_to_die = true


func _ready() -> void:
	$CollisionShape2D.disabled = false
	$AnimatedSprite2D.show()
	$Start.wait_time = start_time
	$Active.wait_time = duration_activated
	$Inactive.wait_time = duration_deactivated
	if not infinite:
		$Start.start()


func _on_start_timeout() -> void:
	$Inactive.start()


func _on_active_timeout() -> void:
	$CollisionShape2D.disabled = true
	$AnimatedSprite2D.hide()
	$Inactive.start()


func _on_inactive_timeout() -> void:
	$CollisionShape2D.disabled = false
	$AnimatedSprite2D.show()
	$Active.start()
