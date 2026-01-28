extends State
@onready var timer: Timer = $Timer

func on_enter():
	animation_component.handle_travel_animation("hit")
	timer.start()

func _on_timer_timeout() -> void:
	next_state = prev_state
