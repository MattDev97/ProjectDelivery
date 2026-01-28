extends State

var player_to_follow : CharacterBody2D

func on_enter():
	player_to_follow = character.player_to_follow
	animation_component.handle_travel_animation("move")

func state_process(delta):
	
	# 1. Calculate the raw difference in positions
	var difference_x = player_to_follow.global_position.x - character.global_position.x
	# 2. Convert that to a simple -1, 0, or 1 direction
	# We use Vector2(x, 0) because your logic expects a Vector2 'direction' variable
	var direction : Vector2 = Vector2(sign(difference_x), 0)

	# Optional: Stop moving if we are very close (e.g., within 20 pixels) to prevent jittering
	if abs(difference_x) < 20:
		direction = Vector2.ZERO

	if direction && can_move:
		character.velocity.x = direction.x * character.movement_speed
	else:
		character.velocity.x = move_toward(character.velocity.x, 0, character.movement_speed)

	# If we aren't moving, don't update sprite flip
	if direction.x == 0:
		return
	
	animation_component.handle_move_animation(direction.x)
