extends Area2D


func _ready() -> void:
	$Activated.hide()
	$Disabled.show()


func _on_body_entered(_body: Node2D) -> void:
	$Disabled.hide()
	$Activated.show()
	Autoload.checkpoint = global_position
