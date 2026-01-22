# scenes/player/fall_state.gd
extends State
class_name FallState

func on_enter():
	# If we came from Ground (Idle/Run), give us Coyote Time
	# You can check the 'name' of the previous state if you track it,
	# or just trust the jump component's logic.
	print(prev_state)
	if prev_state.name == 'Run' || prev_state.name == 'Idle':
		print('start coyote timer')
		jump_component.start_coyote_timer(character)
	
	animation_component.handle_jump_animation(false, true)

func state_process(delta):
		
	var direction = character.input_component.input_horizontal
	movement_component.handle_horizontal_movement(character, direction)
	
	# Buffer the jump (remember input if we press it right before landing)
	jump_component.handle_jump_buffer(character, character.input_component.get_jump_input())
	
	# Transition: Landed
	if character.is_on_floor():
		if direction != 0:
			character.set_next_state("Run")
		else:
			character.set_next_state("Idle")
	
	# Transition: Coyote Jump
	# If we press jump AND the coyote timer is still valid
	if character.input_component.get_jump_input() and jump_component.is_coyote_timer_running():
		print('attempted coyote jump')
		character.set_next_state("Jump")
		
	
