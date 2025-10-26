extends Node2D

@onready var player := get_parent()
@onready var dc := $DashCooldown
@onready var dd := $DashDuration

@export var dash_speed = 700.0

var dash_allowed = true
var is_dashing = false


func _physics_process(_delta: float) -> void:
	if is_dashing:
		player.velocity.x = sign(player.velocity.x) * dash_speed
		player.velocity.y = 0.0
	if can_dash():
		$DashSound.play()
		var direction = Input.get_axis("left", "right")
		if direction:
			player.velocity.x = direction * dash_speed
		dash_allowed = false
		is_dashing = true
		dc.start()
		dd.start()
		

func can_dash() -> bool:
	return 	Input.is_action_just_pressed("dash") and \
			dash_allowed and \
			sign(player.velocity.x) and \
			not player.grapple.launched and \
			not player.wall_jump.is_wall_sliding


func _on_dash_cooldown_timer_timeout():
	dash_allowed = true


func _on_dash_duration_timer_timeout():
	player.velocity.x = sign(player.velocity.x) * 200.0
	is_dashing = false
