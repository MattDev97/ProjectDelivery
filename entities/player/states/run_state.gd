# scenes/player/run_state.gd
extends State
class_name RunState

func on_enter():
	pass 

func state_process(delta):	
	var direction = character.input_component.input_horizontal
	
	# 1. Transition to Idle
	if direction == 0:
		character.set_next_state("Idle")
		
	# 2. Transition to Jump
	if character.input_component.get_jump_input():
		character.set_next_state("Jump")
	
	if !character.is_on_floor() && character.velocity.y > 0:
		character.set_next_state("Fall")

func state_input(event):
	# ADD THIS: Attack Trigger
	if event.is_action_pressed("attack_1"): # Make sure "attack" is in Project Settings -> Input Map
		character.set_next_state("Attack")
