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
const FRICTION = 1000.0 # Ground friction when not moving

@export var animated_sprite_2d: AnimatedSprite2D
@onready var stat_controller: StatController = $StatController

@export_subgroup("Nodes")
@export var gravity_component: GravityComponent
@export var input_component: InputComponent
@export var movement_component: MovementComponent
@export var animation_component: AnimationComponent
@export var action_animation_component: AnimationComponent
@export var jump_component: AdvancedJumpComponent

@export var inventory_component: Inventory

@onready var state_machine: CharacterStateMachine = $CharacterStateMachine
@onready var action_state_machine: ActionStateMachine = $ActionStateMachine

@onready var char_animation_tree: AnimationTree = $"Character Animation/AnimationTree"
@onready var action_animation_tree: AnimationTree = $"Attack Animation/AnimationTree"

@export var damageable: Damageable
@export var knockback_impulse: Vector2 = Vector2(100, -200)

@export var camera: Camera2D

@export_group("Wall Jump")
@export var wall_jump_velocity = Vector2(400.0, -400.0)
var wall_raycast: RayCast2D
var input_locked = false

signal health_changed(new_hp, max_hp)

func _ready() -> void:
	Global.game_controller.player = self
	Global.game_controller.player_camera = camera
	
	damageable.connect("on_hit", on_damageable_hit)
	damageable.connect("on_death", on_damageable_death)
	
	damageable.max_health = stat_controller.get_value("health")
	damageable.health = stat_controller.get_value("health")

	emit_signal("health_changed", damageable.health, damageable.max_health)
	
	# Initialize Animation Component
	if animation_component:
		animation_component.animation_tree = char_animation_tree
	if action_animation_component:
		action_animation_component.animation_tree = action_animation_tree

	# Wall Raycast
	wall_raycast = RayCast2D.new()
	add_child(wall_raycast)
	wall_raycast.target_position = Vector2(30, 0)
	wall_raycast.enabled = true
	
func _physics_process(delta) -> void:
	if state_machine.current_state != null:
		var can_move = state_machine.current_state.can_move && action_state_machine.current_state.can_move
			
		if can_move and not input_locked:
			var direction = input_component.input_horizontal
			movement_component.handle_horizontal_movement(self , direction)
		elif is_on_floor():
			# Apply friction if on floor but can't move (e.g. Knockback landing)
			velocity.x = move_toward(velocity.x, 0, FRICTION * delta)
		
		# Update wall raycast direction
		if input_component.input_horizontal != 0:
			wall_raycast.target_position.x = 30 * input_component.input_horizontal
			
		if animation_component:
			animation_component.update_animations(input_component.input_horizontal, state_machine.current_state.name)
			
		if action_animation_component:
			action_animation_component.update_animations(input_component.input_horizontal, action_state_machine.current_state.name)

	move_and_slide()

func _perform_wall_jump():
	var wall_normal = wall_raycast.get_collision_normal()
	velocity.x = wall_normal.x * wall_jump_velocity.x
	velocity.y = wall_jump_velocity.y
	
func equip_item(item: ItemData):
	inventory_component.add_item(item)
	
func on_damageable_hit(node: Node, damage_amount: int, knockback_direction: Vector2):
	if (damageable.health > 0):
		self.velocity = Vector2(knockback_impulse.x * knockback_direction.x, knockback_impulse.y)
		#take_damage(damage_amount)
		interrupt_state('Hit')
		
		if camera:
			camera.shake(1, 5)
	else:
		set_next_state('Dead')
		
	emit_signal("health_changed", damageable.health, damageable.max_health)
		
func on_damageable_death():
	print('dead state for player')

func set_next_state(nextStateName: String):
	if state_machine.current_state != null:
		state_machine.current_state.next_state = state_machine.get_node(nextStateName)

func interrupt_state(stateName: String):
	if state_machine.current_state != null:
		state_machine.on_state_interrupt_state(state_machine.get_node(stateName))
