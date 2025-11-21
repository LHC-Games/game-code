extends Node2D

@onready var player := get_parent()
@onready var right_wall_cast = $RightWall
@onready var left_wall_cast = $LeftWall

@export var wall_jump_force = 500.0
@export var wall_slide_speed = 200.0

var is_wall_sliding = false


func _physics_process(_delta: float) -> void:
	if on_wall() and not player.is_on_floor() and not player.die.is_die:
		is_wall_sliding = true
		player.velocity.y = min(player.velocity.y, wall_slide_speed)
	else:
		is_wall_sliding = false
		
	if is_wall_sliding and Input.is_action_just_pressed("up"):
		wall_jump()


func on_wall():
	return right_wall_cast.is_colliding() or left_wall_cast.is_colliding()


func wall_jump():
	var wall_normal = right_wall_cast.get_collision_normal() if right_wall_cast.is_colliding() else left_wall_cast.get_collision_normal()
	player.velocity.y = player.jump.jump_velocity
	player.velocity.x = wall_normal.x * wall_jump_force
	$WallJumpSound.play()
