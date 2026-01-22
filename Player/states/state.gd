extends Node


class_name State

@export var can_move : bool = true
@export var can_jump : bool = true

var character : CharacterBody2D
var movement_component: MovementComponent
var jump_component: AdvancedJumpComponent
var gravity_component: GravityComponent
var animation_component: AnimationComponent

var next_state : State
var prev_state : State

func state_process(delta):
	pass

func state_input(event):
	pass
	
func run_state(event):
	pass

func on_enter():
	pass
	
func on_exit():
	pass
