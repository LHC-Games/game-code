extends Area2D



func _on_body_entered(_body: Node2D) -> void:
	Hud.pause_timer()
	get_tree().call_deferred("change_scene_to_file", "res://scenes/Transition.tscn")
	
