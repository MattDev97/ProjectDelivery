# scenes/player/run_state.gd
extends State
class_name RunState

func on_enter():
	# Animation handled by component in process, or force start here
	pass 

func state_process(delta):
	gravity_component.handle_gravity(character, delta)
	
	var direction = character.input_component.input_horizontal
	movement_component.handle_horizontal_movement(character, direction)
	animation_component.handle_move_animation(direction)
	
	# 1. Transition to Idle
	if direction == 0:
		character.set_next_state("Idle")
		
	# 2. Transition to Jump
	if character.input_component.get_jump_input():
		character.set_next_state("Jump")
	
	if !character.is_on_floor() && character.velocity.y > 0:
		character.set_next_state("Fall")
