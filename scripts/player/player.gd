extends CharacterBody2D

@export var white = false

@onready var move := $Move
@onready var dash := $Dash
@onready var jump := $Jump
@onready var wall_jump := $WallJump
@onready var animation := $Animation
@onready var grapple := $Grapple
@onready var die := $Die
@onready var collision_shape := $CollisionShape2D
@onready var wall_slide := $WallSlide
@onready var gravity := $Gravity
@onready var right_wall_cast = $WallJump/RightWall
@onready var left_wall_cast = $WallJump/LeftWall


func _ready() -> void:
	set_floor_max_angle(0.7)
	Autoload.checkpoint = global_position
	if white:
		self.modulate = Color(10000, 10000, 10000, 1)
	Autoload.player = self


func _physics_process(_delta: float) -> void:
	move_and_slide()
	if right_wall_cast.is_colliding():
		wall_slide.flip_h = true
		var tmp: Vector2
		tmp.x = -27
		tmp.y = 0
		wall_slide.position = tmp
	elif left_wall_cast.is_colliding():
		wall_slide.flip_h = false
		var tmp: Vector2
		tmp.x = 18
		tmp.y = 0
		wall_slide.position = tmp
