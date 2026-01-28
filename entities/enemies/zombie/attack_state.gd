extends State

@export var attack_timer : Timer 

func on_enter():
	character.velocity.x = 0
	attack_timer.start()
	animation_component.handle_travel_animation("attack")

func _on_timer_timeout() -> void:
	next_state = prev_state
