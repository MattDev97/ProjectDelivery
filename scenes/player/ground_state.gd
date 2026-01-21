extends State
class_name GroundState
	
func state_process(delta):
	character.movement_component.handle_horizontal_movement(
		character,
		character.input_component.input_horizontal
	)
	
	character.jump_component.handle_jump_buffer(
		character,
		character.input_component.get_jump_input()
	)
	
	if character.jump_component.has_just_stepped_off_ledge(character):
		character.jump_component.start_coyote_timer(character)
		
	if !character.is_on_floor() && !character.jump_component.is_coyote_timer_running():
		character.set_next_state("Air")
		
	character.jump_component.set_last_frame_on_floor(character)

func state_input(event):
	if character.jump_component.is_allowed_to_jump(
		character,
		character.input_component.get_jump_input()
	):
		character.jump_component.jump(character)
