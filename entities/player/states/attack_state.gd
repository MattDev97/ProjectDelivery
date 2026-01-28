extends State
class_name AttackState

@export var return_state : State
@export var attack_col : CollisionShape2D
@export var attack_damage : float = 10.0
@export var attack_timer : Timer 

# Timer for "combo" windows (optional, but good for polish)
var is_attacking : bool = false

func on_enter():
	is_attacking = true
	
	#character.velocity.x = 0
	
	animation_component.handle_travel_animation("attack_1")
	attack_timer.start()

func _on_timer_timeout() -> void:
	character.set_next_state('Idle')
