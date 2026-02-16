class_name AdvancedJumpComponent
extends Node

@export_subgroup("settings")
#@export var jump_velocity: float = -700

@export_subgroup("Nodes")
@export var jump_buffer_timer: Timer
@export var coyote_timer: Timer

var is_going_up: bool = false
var is_jumping: bool = false
var last_frame_on_floor: bool = false

func is_allowed_to_jump(body: CharacterBody2D, want_to_jump: bool) -> bool:
	return want_to_jump and (
			(body.is_on_floor() or not coyote_timer.is_stopped())
		)

func has_just_stepped_off_ledge(body: CharacterBody2D) -> bool:
	return not body.is_on_floor() and last_frame_on_floor	

func start_coyote_timer(body: CharacterBody2D) -> void:
	coyote_timer.start()
		
func is_coyote_timer_running():
	return not coyote_timer.is_stopped()
	
func handle_variable_jump_height(body: CharacterBody2D, jump_released: bool) -> void:
	if jump_released and char_is_going_up:
		body.velocity.y = 0
		
func jump(body: CharacterBody2D) -> void:
	var jump_velocity = body.stat_controller.get_value("jump_velocity")

	body.velocity.y = -jump_velocity
	jump_buffer_timer.start()
	is_jumping = true
	coyote_timer.stop()

func handle_jump_buffer(body: CharacterBody2D, want_to_jump: bool) -> void:
	if want_to_jump and not body.is_on_floor():
		jump_buffer_timer.start()
		
	if body.is_on_floor() and not jump_buffer_timer.is_stopped():
		jump(body)
		
		
func set_last_frame_on_floor(body: CharacterBody2D):
	last_frame_on_floor = body.is_on_floor()

func char_is_going_up(body: CharacterBody2D):
	return body.velocity.y < 0 and not body.is_on_floor()
