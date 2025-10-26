extends Area2D


enum element_enum {BEGIN}

@export var direction: Autoload.direction_enum = Autoload.direction_enum.LEFT
var element: element_enum = element_enum.BEGIN


func _ready() -> void:
	if element == element_enum.BEGIN:
		$AnimatedSprite2D.play("beginning")


func _on_body_entered(_body: Node2D) -> void:
	Autoload.in_the_wind = true
	Autoload.wind_direction = direction


func _on_body_exited(_body: Node2D) -> void:
	Autoload.in_the_wind = false
