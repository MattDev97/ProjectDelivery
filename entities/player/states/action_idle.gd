extends State
class_name ActionIdle

@export var attack_state: State

func state_input(event: InputEvent):
	# Replace "attack" with your actual input map action name
	if event.is_action_pressed("attack_1"):
		next_state = attack_state
