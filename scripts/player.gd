extends CharacterBody2D


@export var move_speed = 300.0
@export var dash_speed = 700.0
var move_speed_variation = 0.0
@export var acceleration = 1500.0
@export var friction = 3000.0
@export var jump_velocity = -400.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var can_dash = true
var is_dashing = false
var is_die = false
@export var wall_jump_force = 500.0
@export var wall_slide_speed = 100.0
var is_wall_sliding = false


@onready var animated_sprite = $AnimatedSprite2D
@onready var gc := $GrappleController
@onready var dc := $DashCooldown
@onready var dd := $DashDuration
@onready var right_wall_cast = $WallJump/RightWall
@onready var left_wall_cast = $WallJump/LeftWall


func _ready() -> void:
	set_floor_max_angle(0.7)
	Autoload.checkpoint = global_position


func _physics_process(delta: float) -> void:
	if is_on_floor():
		gc.retract()
	handle_wall_slide()
	jump(delta)
	speed_update(delta)
	move_and_slide()
	if not is_die:
		die_check()
	if Input.is_action_just_pressed("respawn"):
		die()
	animation()


func speed_update(delta: float) -> void:
	if is_dashing:
		velocity.x = sign(velocity.x) * dash_speed
		velocity.y = 0.0
	elif is_on_floor() or is_wall_sliding:
		var direction = Input.get_axis("left", "right")
		if direction:
			velocity.x = move_toward(velocity.x, direction * (move_speed + move_speed_variation), acceleration*delta)
		else:
			velocity.x = move_toward(velocity.x, 0, friction*delta)
	if Input.is_action_just_pressed("dash") and can_dash and sign(velocity.x) and not gc.launched and not is_wall_sliding:
		var direction = Input.get_axis("left", "right")
		if direction:
			velocity.x = direction * dash_speed
		can_dash = false
		is_dashing = true
		dc.start()
		dd.start()


func jump(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta

	if is_on_floor() and Input.is_action_just_pressed("up"):
		velocity.y = jump_velocity
	elif is_wall_sliding and Input.is_action_just_pressed("up"):
		wall_jump()


func _on_dash_cooldown_timer_timeout():
	can_dash = true


func _on_dash_duration_timer_timeout():
	velocity.x = sign(velocity.x) * 200.0
	is_dashing = false


func die_check() -> void:
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision:
			var collider_rid = collision.get_collider_rid()
			var layer_mask = PhysicsServer2D.body_get_collision_layer(collider_rid)
			if layer_mask == 4:
				die()
				break


func die() -> void:
	$CollisionShape2D.disabled = true
	is_die = true
	modulate = Color(0.75, 0.75, 0.75, 0.5)
	velocity.x = 0.0
	velocity.y = 0.0
	gravity = -100
	await get_tree().create_timer(2.0).timeout
	velocity.x = 0.0
	velocity.y = 0.0
	gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
	global_position = Autoload.checkpoint
	$CollisionShape2D.disabled = false
	is_die = false
	modulate = Color(1, 1, 1, 1)


func on_wall():
	return right_wall_cast.is_colliding() or left_wall_cast.is_colliding()


func handle_wall_slide():
	if on_wall() and not is_on_floor():
		is_wall_sliding = true
		velocity.y = min(velocity.y, wall_slide_speed)
	else:
		is_wall_sliding = false


func wall_jump():
	var wall_normal = right_wall_cast.get_collision_normal() if right_wall_cast.is_colliding() else left_wall_cast.get_collision_normal()
	velocity.y = jump_velocity
	velocity.x = wall_normal.x * wall_jump_force


func animation() -> void:
	if velocity.x < 0:
		animated_sprite.flip_h = true
	elif velocity.x > 0:
		animated_sprite.flip_h = false

	if is_dashing:
		animated_sprite.play("dash")
	elif not is_on_floor():
		if is_wall_sliding:
			animated_sprite.play("wall_slide")
		else:
			animated_sprite.play("idle")
	else:
		if not is_zero_approx(velocity.x):
			animated_sprite.play("walk")
		else:
			animated_sprite.play("idle")
