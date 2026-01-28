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

# --- PLAYER STATS ---
@export_group("Stats")
@export var player_stats: PlayerStats 
# ------------------------


@export var animated_sprite_2d: AnimatedSprite2D


@export_subgroup("Nodes")
@export var gravity_component: GravityComponent
@export var input_component: InputComponent
@export var movement_component: MovementComponent
@export var animation_component: AnimationComponent
@export var jump_component: AdvancedJumpComponent

@onready var state_machine : CharacterStateMachine = $CharacterStateMachine
@onready var animation_tree : AnimationTree = $Animation/AnimationTree

@export var damageable : Damageable
@export var knockback_speed : float = 200

signal health_changed(new_hp, max_hp)

var max_hp = 100
var current_hp = 100

func _ready() -> void:
	damageable.connect("on_hit", on_damageable_hit)
	animation_tree.active = true
	var character_name = Global.game_controller.character
	animated_sprite_2d = self.get_node(character_name)
	
	if player_stats:
		# 1. Setup Health
		max_hp = player_stats.max_health
		current_hp = max_hp
		
		damageable.health = max_hp
		
		Global.game_controller.player_health = max_hp
		Global.game_controller.max_player_health = max_hp
		
		# 2. Setup Movement Speed (Injecting into your component)
		if movement_component:
			movement_component.speed = player_stats.move_speed 
			
		# Optional: Setup Jump Force (if you want to implement that later)
		if jump_component:
			jump_component.jump_velocity = -player_stats.jump_force 
	# ------------------------
	
func on_damageable_hit(node : Node, damage_amount : int, knockback_direction: Vector2):
	if(damageable.health > 0):
		self.velocity = knockback_speed * knockback_direction
		take_damage(damage_amount)
		interrupt_state('Hit')
		
func take_damage(amount):
	current_hp -= amount
	Global.game_controller.player_health_update(damageable.health)

func _physics_process(delta) -> void:
	
	if state_machine.current_state != null && state_machine.current_state.can_move == true:
		var direction = input_component.input_horizontal
		movement_component.handle_horizontal_movement(self, direction)

	move_and_slide()
	
func set_next_state(nextStateName : String):
	if state_machine.current_state != null:
		state_machine.current_state.next_state = state_machine.get_node(nextStateName)

func interrupt_state(stateName : String):
	if state_machine.current_state != null:
		state_machine.on_state_interrupt_state(state_machine.get_node(stateName))
