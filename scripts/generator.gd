extends Node2D

@export var pink: PackedScene
@export var blue: PackedScene
@export var yellow: PackedScene
@export var green: PackedScene
var spawn_radius = 400.0
var difficulty = 0.0


func _on_pink_respawn_timeout() -> void:
	var new_pink = pink.instantiate()
	new_pink.difficulty = difficulty
	var spawn_center = Autoload.player.global_position
	var random_angle = randf_range(0.0, 2.0 * PI)
	var random_offset = Vector2.from_angle(random_angle) * spawn_radius
	new_pink.global_position = spawn_center + random_offset
	add_child(new_pink)
	print("Nova criança! :) em " + str(new_pink.global_position))


func _on_yellow_respawn_timeout() -> void:
	var new_yellow = yellow.instantiate()
	new_yellow.difficulty = difficulty
	var spawn_center = Autoload.player.global_position
	var random_angle = randf_range(0.0, 2.0 * PI)
	var random_offset = Vector2.from_angle(random_angle) * spawn_radius
	new_yellow.global_position = spawn_center + random_offset
	add_child(new_yellow)


func _on_blue_respawn_timeout() -> void:
	var new_blue = blue.instantiate()
	new_blue.difficulty = difficulty
	var spawn_center = Autoload.player.global_position
	var random_angle = randf_range(0.0, 2.0 * PI)
	var random_offset = Vector2.from_angle(random_angle) * spawn_radius
	new_blue.global_position = spawn_center + random_offset
	add_child(new_blue)


func _on_green_respawn_timeout() -> void:
	var new_green = green.instantiate()
	new_green.difficulty = difficulty
	var spawn_center = Autoload.player.global_position
	var random_angle = randf_range(0.0, 2.0 * PI)
	var random_offset = Vector2.from_angle(random_angle) * spawn_radius
	new_green.global_position = spawn_center + random_offset
	add_child(new_green)


func _on_increase_difficulty_timeout() -> void:
	pass # Replace with function body.
