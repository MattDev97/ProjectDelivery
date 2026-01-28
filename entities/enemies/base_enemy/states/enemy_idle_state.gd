extends State

# Called when the node enters the scene tree for the first time.
func on_enter():
	animation_component.handle_travel_animation("move")
	animation_component.handle_move_animation(0)
	
	character.velocity.x = 0
