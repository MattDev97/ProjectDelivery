# scenes/player/wall_slide_state.gd
extends State
class_name WallSlideState

@export var wall_slide_speed = 150.0

func on_enter():
	pass 

func state_process(delta):
	# Apply wall slide gravity
	character.velocity.y = move_toward(character.velocity.y, wall_slide_speed, character.gravity_component.gravity * delta)

	# Transition: Let go of wall or on ground
	if not (character.wall_raycast_right.is_colliding() or character.wall_raycast_left.is_colliding()) or character.is_on_floor():
		character.set_next_state("Fall")

	# Transition: Wall Jump
	if character.input_component.get_jump_input():
		character.set_next_state("Jump")
	
	var char_wall_slide_raycast : RayCast2D = character.get_wall_raycast_colliding()
	
	# Transition: if player stops holding towards wall
	if character.input_component.input_horizontal == 0:
		character.set_next_state("Fall")
	elif char_wall_slide_raycast != null and sign(character.input_component.input_horizontal) != sign(char_wall_slide_raycast.target_position.x):
		character.set_next_state("Fall")
