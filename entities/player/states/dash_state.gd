# scenes/player/states/dash_state.gd
extends State
class_name DashState

@onready var dash_timer: Timer = $DashTimer

@export var dash_distance: float = 75.0

var dash_direction: int = 1

func on_enter():
	dash_timer.start()
	character.input_locked = true
	
	if character.input_component.input_horizontal != 0:
		dash_direction = sign(character.input_component.input_horizontal)
	elif character.velocity.x != 0:
		dash_direction = sign(character.velocity.x)
	else:
		dash_direction = 1

func on_exit():
	dash_timer.stop()
	character.input_locked = false

func state_process(delta):
	var speed = 0.0
	if dash_timer.wait_time > 0:
		speed = dash_distance / dash_timer.wait_time
	character.velocity = Vector2(dash_direction * speed, 0)

func _on_dash_timer_timeout() -> void:
	if character.is_on_floor():
		if character.input_component.input_horizontal != 0:
			character.set_next_state("Run")
		else:
			character.set_next_state("Idle")
	else:
		character.set_next_state("Fall")
