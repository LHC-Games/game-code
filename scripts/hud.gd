extends CanvasLayer

@onready var timer_label: Label = $Timer
var elapsed_time: float = 0.0
var pause: bool = true


func _ready() -> void:
	pause = true
	timer_label.hide()


func _process(delta: float) -> void:
	if not pause:
		elapsed_time += delta
		var minutes: int = int(elapsed_time / 60)
		var seconds: int = int(elapsed_time) % 60
		timer_label.text = "%02d:%02d" % [minutes, seconds]


func reset_timer() -> void:
	elapsed_time = 0.0


func pause_timer() -> void:
	pause = true
	

func unpause_timer() -> void:
	pause = false
	

func hide_timer() -> void:
	timer_label.hide()
	
	
func show_timer() -> void:
	timer_label.show()
