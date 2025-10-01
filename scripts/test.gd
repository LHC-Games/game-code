extends Node2D


func _on_final_point_body_entered(_body: Node2D) -> void:
	#get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")
	get_tree().call_deferred("change_scene_to_file", "res://scenes/MainMenu.tscn")
