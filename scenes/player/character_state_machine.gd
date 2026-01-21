extends Node

class_name CharacterStateMachine

@export var character : CharacterBody2D
@export var current_state : State

@export_subgroup("Components")
@export var movement_component: MovementComponent
@export var jump_component: AdvancedJumpComponent
@export var gravity_component: GravityComponent
@export var animation_component: AnimationComponent

var states : Array[State]

func _ready():
	for child in get_children():
		if(child is State):
			states.append(child)
			
			child.character = character
			child.movement_component = movement_component
			child.jump_component = jump_component
			child.gravity_component = gravity_component
			child.animation_component = animation_component
		else:
			push_warning("Child " + child.name + " is not a state for CharacterStateMachine.")

func _physics_process(delta: float) -> void:
	if(current_state.next_state != null):
		switch_states(current_state.next_state)
		
	current_state.state_process(delta)

func check_if_can_move():
	return current_state.can_move

func check_if_can_jump():
	return current_state.can_jump
	
func switch_states(new_state : State):
	
	if(current_state != null):
		# Makes sure that if we enter new state, old state is cleared
		current_state.on_exit()
		current_state.next_state = null
		
		# Previous State
		new_state.prev_state = current_state
	
	current_state = new_state
	current_state.on_enter()

func _input(event : InputEvent):
	current_state.state_input(event)
