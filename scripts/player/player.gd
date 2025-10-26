extends CharacterBody2D

@onready var move := $Move
@onready var dash := $Dash
@onready var jump := $Jump
@onready var wall_jump := $WallJump
@onready var animation := $Animation
@onready var grapple := $Grapple
@onready var die := $Die
@onready var collision_shape := $CollisionShape2D
@onready var gravity := $Gravity


func _ready() -> void:
	set_floor_max_angle(0.7)
	Autoload.checkpoint = global_position


func _physics_process(_delta: float) -> void:
	move_and_slide()
