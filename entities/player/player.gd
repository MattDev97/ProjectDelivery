extends CharacterBody2D

class_name Player

enum State {
	Idle, Run, Jump, Fall, Crouch
}

var current_state

#const SPEED = 300.0
const JUMP_VELOCITY = -700.0
const JUMP_HORIZONTAL = 100
const GRAVITY = 2500

@export var animated_sprite_2d: AnimatedSprite2D
@onready var stat_controller: StatController = $StatController

@export_subgroup("Nodes")
@export var gravity_component: GravityComponent
@export var input_component: InputComponent
@export var movement_component: MovementComponent
@export var animation_component: AnimationComponent
@export var jump_component: AdvancedJumpComponent

@export var inventory_component : Inventory

@onready var state_machine: CharacterStateMachine = $CharacterStateMachine
@onready var animation_tree: AnimationTree = $Animation/AnimationTree

@export var damageable: Damageable
@export var knockback_speed: float = 200

var state_dictionary: Dictionary

signal health_changed(new_hp, max_hp)

func _ready() -> void:
	Global.game_controller.player = self
	
	damageable.connect("on_hit", on_damageable_hit)
	damageable.connect("on_death", on_damageable_death)
	
	damageable.max_health = stat_controller.get_value("health")
	damageable.health = stat_controller.get_value("health")

	emit_signal("health_changed", damageable.health, damageable.max_health)
	
	# Initialize Animation Component
	if animation_component:
		animation_component.animation_tree = animation_tree
	if jump_component:
			jump_component.jump_velocity = -700
	
func _physics_process(delta) -> void:
	if state_machine.current_state != null:
		if state_machine.current_state.can_move == true:
			var direction = input_component.input_horizontal
			movement_component.handle_horizontal_movement(self , direction)
		
		if animation_component:
			animation_component.update_animations(input_component.input_horizontal, state_machine.current_state.name)

	move_and_slide()
	
func equip_item(item: ItemData):
	inventory_component.add_item(item)
	
func on_damageable_hit(node: Node, damage_amount: int, knockback_direction: Vector2):
	if (damageable.health > 0):
		self.velocity = knockback_speed * knockback_direction
		#take_damage(damage_amount)
		interrupt_state('Hit')
		emit_signal("health_changed", damageable.health, damageable.max_health)
		
func on_damageable_death():
	print('dead state for player')

func set_next_state(nextStateName: String):
	if state_machine.current_state != null:
		state_machine.current_state.next_state = state_machine.get_node(nextStateName)

func interrupt_state(stateName: String):
	if state_machine.current_state != null:
		state_machine.on_state_interrupt_state(state_machine.get_node(stateName))
