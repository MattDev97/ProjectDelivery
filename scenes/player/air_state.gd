extends State
class_name AirState

func state_process(delta):
	character.movement_component.handle_horizontal_movement(
		character,
		character.input_component.input_horizontal
	)
	
	character.jump_component.handle_jump_buffer(
		character,
		character.input_component.get_jump_input()
	)
	
	if(character.is_on_floor()):
		character.set_next_state("Ground")
	pass

func state_input(event):
	character.jump_component.handle_variable_jump_height(
		character,
		character.input_component.get_jump_input_released()
	)
	
func is_going_up(delta):
	return character.velocity.y < 0 and not character.is_on_floor()
