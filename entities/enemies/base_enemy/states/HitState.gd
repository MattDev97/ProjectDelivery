extends State

class_name HitState

@export var damageable : Damageable
@export var dead_state : State
@export var character_state_machine : CharacterStateMachine
@export var animated_sprite : AnimatedSprite2D

@export var return_state : State

@onready var timer : Timer = $Timer

func on_enter():
	animation_component.handle_travel_animation("hurt")
	timer.start()

func on_exit():
	character.velocity = Vector2.ZERO

func _on_timer_timeout() -> void:
	next_state = return_state
	pass # Replace with function body.
