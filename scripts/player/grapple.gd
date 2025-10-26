extends Node2D

@export var default_rest_length = 250.0

@onready var player := get_parent()
@onready var ray := $RayCast2D
@onready var rope := $Line2D

var rest_length = default_rest_length
var stiffness = 100.0
var damping = 10.0
var launched = false
var target: Vector2


func _physics_process(delta: float) -> void:
	if not player.die.is_die:
		ray.look_at(get_global_mouse_position())
		if player.is_on_floor() and launched:
			retract()
		if Input.is_action_just_pressed("grapple"):
			launch()
		if Input.is_action_just_released("grapple") and launched:
			retract()
		if launched:
			handle_grapple(delta)


func launch():
	if can_grapple():
		$GrappleLauchSound.play()
		launched = true
		rest_length = player.global_position.distance_to(ray.get_collision_point()) -10
		target = ray.get_collision_point()
		rope.show()


func retract():
	$GrappleRetractSound.play()
	launched = false
	rope.hide()


func handle_grapple(delta):
	var target_dir = player.global_position.direction_to(target)
	var target_dist = player.global_position.distance_to(target)
	var displacement = target_dist - rest_length
	var force = Vector2.ZERO
	if displacement > 0:
		var spring_force_magnitude = stiffness * displacement
		var spring_force = target_dir * spring_force_magnitude
		var vel_dot = player.velocity.dot(target_dir)
		var damp = -damping * vel_dot * target_dir
		force = spring_force + damp
	player.velocity += force * delta
	update_rope()


func update_rope():
	rope.set_point_position(1, to_local(target))


func can_grapple() -> bool:
	return 	ray.is_colliding() and \
			not player.is_on_floor() and \
			not player.dash.is_dashing and \
			player.global_position.distance_to(ray.get_collision_point()) <= default_rest_length
