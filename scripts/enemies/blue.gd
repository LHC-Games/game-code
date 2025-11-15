extends CharacterBody2D

@export var speed = 300.0
@export var difficulty = 0.0

# --- Novas variáveis para o movimento senoidal ---
# Frequência: Quantas "ondas" completas por segundo.
@export var wave_frequency = 1.0 
# Amplitude: O ângulo máximo (em radianos) que ele vai desviar.
@export var wave_angle_amplitude = 1.0
# ------------------------------------------------

var base_direction: Vector2
var time = 0.0

func _ready() -> void:
	var target = Autoload.player.global_position
	# Armazena a direção central inicial
	base_direction = (target - global_position).normalized()

func _physics_process(delta):
	time += delta

	# 1. Calcular a velocidade angular (radianos/segundo)
	var angular_frequency = wave_frequency * 2.0 * PI

	# 2. Calcular o ângulo de desvio atual usando seno
	var angle_offset = sin(time * angular_frequency) * wave_angle_amplitude

	# 3. Rotacionar a direção base pelo ângulo de desvio
	var current_direction = base_direction.rotated(angle_offset)

	# 4. Definir a velocidade final
	velocity = current_direction * (speed + difficulty)
	
	move_and_slide()

func _on_timeout_timeout() -> void:
	queue_free()
