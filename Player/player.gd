extends CharacterBody2D

class_name Player

enum State {
	Idle, Run, Jump, Fall, Crouch
}

var current_state

const SPEED = 300.0
const JUMP_VELOCITY = -700.0
const JUMP_HORIZONTAL = 100
const GRAVITY = 2500



@export var animated_sprite_2d: AnimatedSprite2D

@export_subgroup("Nodes")
@export var gravity_component: GravityComponent
@export var input_component: InputComponent
@export var movement_component: MovementComponent
@export var animation_component: AnimationComponent
@export var jump_component: AdvancedJumpComponent

@onready var state_machine: CharacterStateMachine = $CharacterStateMachine

signal health_changed(new_hp, max_hp)

var max_hp = 100
var current_hp = 100

func take_damage(amount):
	current_hp -= amount
	
	Global.game_controller.player_health_update(current_hp)
	# Emit the signal!
	

func _ready() -> void:
	var character_name = Global.game_controller.character
	animated_sprite_2d = self.get_node(character_name)
	
	self.get_node('AnimationComponent').sprite = animated_sprite_2d
	if animated_sprite_2d != null:
		animated_sprite_2d.visible = true
	

func _physics_process(delta) -> void:
	
	#gravity_component.handle_gravity(self, delta)
	#movement_component.handle_horizontal_movement(self, input_component.input_horizontal)
	#jump_component.handle_jump(self, input_component.get_jump_input(), input_component.get_jump_input_released())
	

	#if is_on_floor():
		#animation_component.handle_move_animation(input_component.input_horizontal)

	#animation_component.handle_jump_animation(jump_component.is_going_up, gravity_component.is_falling)

	move_and_slide()
	
func set_next_state(nextStateName : String):
	if state_machine.current_state != null:
		state_machine.current_state.next_state = state_machine.get_node(nextStateName)
