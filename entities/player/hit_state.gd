extends State
@onready var timer: Timer = $Timer

func on_enter():
	timer.start()

func _on_timer_timeout() -> void:
	next_state = prev_state
