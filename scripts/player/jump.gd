extends Node2D

@onready var player := get_parent()
@export var jump_velocity = -400.0

@export var coyote_duration: float = 0.12
var coyote_timer: float = 0.0

@export var jump_buffer_time: float = 0.1
var jump_buffer_counter: float = 0.0

func _physics_process(_delta: float) -> void:
	if not player.die.is_die and player.is_on_floor() and Input.is_action_just_pressed("up"):
			player.velocity.y = jump_velocity
			$JumpSound.play()
			
#===========================================Coyote Timer=====================================
	if Input.is_action_pressed("up"):
		jump_buffer_counter = jump_buffer_time
		
	if jump_buffer_counter > 0:
		jump_buffer_counter -= _delta
			
			
	# Verifica se há um pulo na memória (buffer > 0) E se pode pular (coyote > 0 ou is_on_floor)
	if jump_buffer_counter > 0 and (player.is_on_floor() or coyote_timer > 0):
			player.velocity.y = -400
			jump_buffer_counter = 0.0
			coyote_timer = 0.0
#============================================================================================
	
#===========================================Coyote Timer=====================================
	if player.is_on_floor():
		coyote_timer = coyote_duration #se tiver no chão reseta o tempo para o máximo
	
	else:
		coyote_timer -= _delta
		
	if Input.is_action_just_pressed("up"):
		jump_buffer_counter = jump_buffer_time
		
		if coyote_timer > 0.0:
			player.velocity.y = jump_velocity
			coyote_timer = 0.0
		
#===============================================================================================

func perform_jump() -> void:
	player.velocity.y = jump_velocity
	jump_buffer_counter = 0.0 # Reseta buffer para não pular de novo
	coyote_timer = 0.0        # Reseta coyote para não pular de novo
	
	$JumpSound.play()
