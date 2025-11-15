extends Node

enum direction_enum {LEFT, RIGHT}

var checkpoint: Vector2
var needs_to_die: bool = false
var in_the_wind: bool = false
var wind_direction: direction_enum = direction_enum.LEFT
var player
var in_software: bool = false
var current_level: int = 1
var player_name: String = "Player"


# Variável para guardar os scores na memória
var ranking_data: Array = []
# Caminho do ficheiro para persistir os scores
const RANKING_SAVE_PATH = "user://ranking.data"

func _ready() -> void:
	# Carrega os scores guardados quando o jogo inicia
	load_ranking()

func save_ranking() -> void:
	# Abre o ficheiro em modo de escrita
	var file = FileAccess.open(RANKING_SAVE_PATH, FileAccess.WRITE)
	if file:
		# Guarda a variável (Godot trata a serialização)
		file.store_var(ranking_data)
	else:
		print("Erro ao salvar o ficheiro de ranking.")

func load_ranking() -> void:
	# Verifica se o ficheiro existe
	if FileAccess.file_exists(RANKING_SAVE_PATH):
		var file = FileAccess.open(RANKING_SAVE_PATH, FileAccess.READ)
		if file:
			# Carrega os dados na variável
			ranking_data = file.get_var()
		else:
			print("Erro ao carregar o ficheiro de ranking.")
	else:
		ranking_data = []
