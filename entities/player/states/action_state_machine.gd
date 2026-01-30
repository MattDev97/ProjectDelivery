class_name ActionStateMachine extends Node

@export var character: CharacterBody2D
@export var current_state: State

var states: Array[State]

func _ready():
	for child in get_children():
		if child is State:
			states.append(child)
			child.character = character
	
	if current_state:
		current_state.on_enter()

func _physics_process(delta: float) -> void:
	if current_state.next_state != null:
		switch_states(current_state.next_state)
	
	current_state.state_process(delta)

func _input(event: InputEvent):
	if current_state:
		current_state.state_input(event)

func switch_states(new_state: State):
	if current_state:
		current_state.on_exit()
		current_state.next_state = null
	
	current_state = new_state
	current_state.on_enter()
