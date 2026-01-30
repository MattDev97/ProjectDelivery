# scenes/player/idle_state.gd
extends State
class_name IdleState

func on_enter():
	pass

func state_process(delta):
	
	# Decelerate to 0 since input is 0
	movement_component.handle_horizontal_movement(character, 0)
	
	if !character.is_on_floor() && character.velocity.y > 0:
		character.set_next_state("Fall")
		
	# 1. Transition to Run
	if character.input_component.input_horizontal != 0:
		character.set_next_state("Run")
		
	# 2. Transition to Jump
	if character.input_component.get_jump_input():
		character.set_next_state("Jump")
		
	
#
#func state_input(event):
	## ADD THIS: Attack Trigger
	#if event.is_action_pressed("attack_1"): # Make sure "attack" is in Project Settings -> Input Map
		#character.set_next_state("Attack")
