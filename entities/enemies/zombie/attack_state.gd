extends State

@export var attack_timer: Timer

func on_enter():
	character.velocity.x = 0
	attack_timer.start()

func _on_timer_timeout() -> void:
	if character.has_method("is_player_in_attack_range") and character.is_player_in_attack_range():
		next_state = self
	else:
		next_state = prev_state
