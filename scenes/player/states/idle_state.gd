# scenes/player/idle_state.gd
extends State
class_name IdleState

func on_enter():
	animation_component.handle_move_animation(0) # Play Idle anim

func state_process(delta):
	# Apply Gravity (Global rule, usually good to keep everywhere)
	gravity_component.handle_gravity(character, delta)
	
	# Decelerate to 0 since input is 0
	movement_component.handle_horizontal_movement(character, 0)
	
	# 1. Transition to Run
	if character.input_component.input_horizontal != 0:
		character.set_next_state("Run")
		
	# 2. Transition to Jump
	if character.input_component.get_jump_input():
		character.set_next_state("Jump")
		
	if !character.is_on_floor() && character.velocity.y > 0:
		character.set_next_state("Fall")
