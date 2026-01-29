# scenes/player/jump_state.gd
extends State
class_name JumpState

func on_enter():
	# Actually perform the jump force immediately
	jump_component.jump(character)

func state_process(delta):
	# Air control
	var direction = character.input_component.input_horizontal
	
	# Variable Jump Height (releasing button cuts jump short)
	if character.input_component.get_jump_input_released():
		jump_component.handle_variable_jump_height(character, true)
	
	# Transition: Falling
	# If we started moving down, we are now falling
	if character.velocity.y > 0 && !character.is_on_floor():
		character.set_next_state("Fall")
	elif character.is_on_floor() && character.velocity.y == 0:
		character.set_next_state("Idle") # or Run
