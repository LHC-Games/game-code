extends CharacterBody2D

var move_speed = 300.0
var move_speed_variation = 0.0
var acceleration = 1500.0
var friction = 1500.0
var jump_velocity = -400.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite = $AnimatedSprite2D
@onready var gc := $GrappleController

func _physics_process(delta: float) -> void:
	gc.launched
	jump(delta)
	speed_update(delta)
	move_and_slide()
	animation()

func speed_update(delta: float) -> void:
	if is_on_floor():
		var direction = Input.get_axis("left", "right")
		if direction:
			velocity.x = move_toward(velocity.x, direction * (move_speed + move_speed_variation), acceleration*delta)
		else:
			velocity.x = move_toward(velocity.x, 0, friction*delta)

func jump(delta) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta
	elif Input.is_action_just_pressed("up"):
		velocity.y = jump_velocity
		gc.retract()

func animation() -> void:
	if velocity.x < 0:
		animated_sprite.flip_h = true
	elif velocity.x > 0:
		animated_sprite.flip_h = false
		
	if not is_on_floor():
		animated_sprite.play("jump")
	else:
		if not is_zero_approx(velocity.x):
			animated_sprite.play("run")
		else:
			animated_sprite.play("idle")
