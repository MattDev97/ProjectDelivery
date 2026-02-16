# scenes/player/jump_state.gd
extends State
class_name JumpState

@export var wall_jump_input_lock_duration = 0.1

func on_enter():
	# Check if we are coming from a wall slide
	if prev_state.name == "WallSlide" or jump_component.is_wall_coyote_timer_running():
		character._perform_wall_jump()
		character.input_locked = true
		get_tree().create_timer(wall_jump_input_lock_duration).connect("timeout", func(): character.input_locked = false)
	else:
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
