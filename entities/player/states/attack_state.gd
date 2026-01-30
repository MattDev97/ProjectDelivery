extends State
class_name AttackState

@export var return_state: State
@export var attack_col: CollisionShape2D
@export var attack_damage: float = 10.0
@export var attack_timer: Timer

# Timer for "combo" windows (optional, but good for polish)
var is_attacking: bool = false

func on_enter():
	is_attacking = true
	attack_timer.start()

func on_exit():
	is_attacking = false

func _on_timer_timeout() -> void:
	next_state = return_state

# This function allows the Player script to ask "Should I stop moving?"
func should_block_movement() -> bool:
	return true
