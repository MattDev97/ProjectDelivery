extends CharacterBody2D

@onready var zombie_sprite: Sprite2D = $"../Animation/Sprite2D"

@onready var state_machine: CharacterStateMachine = $CharacterStateMachine
@onready var stat_controller: StatController = $StatController
@export var attack_controller: Node

@export var starting_move_direction: Vector2 = Vector2.LEFT
@export var movement_speed: float = 30
@export var hit_state: State
@export var dead_state: State
@export var attack_state: State
@export var vision: Area2D

@export var damageable: Damageable
@export var animation_component: AnimationComponent
@export var movement_component: MovementComponent

@export var attack_range: Area2D

var is_following = false
var player_to_follow: Player

@export var knockback_speed: float = 100.0

func _ready() -> void:
	vision.connect("on_player_enter", on_player_enter)
	damageable.connect("on_hit", on_damageable_hit)
	damageable.connect("on_death", on_damageable_death)
	attack_range.connect("on_player_enter", trigger_attack_player)
	
	damageable.max_health = stat_controller.get_value("health")
	damageable.health = stat_controller.get_value("health")
	
	attack_controller.damage = stat_controller.get_value("damage")

func on_damageable_hit(node: Node, damage_amount: int, knockback_direction: Vector2):
	if (damageable.health > 0):
		print('on damageable hit')
		self.velocity = knockback_speed * knockback_direction
		state_machine.on_state_interrupt_state(hit_state)
	else:
		state_machine.on_state_interrupt_state(dead_state)
		#animated_sprite.play('die')

func on_damageable_death():
	state_machine.on_state_interrupt_state(dead_state)

func _physics_process(delta: float) -> void:
	if animation_component and state_machine.current_state:
		# Pass velocity.x as direction and the current state name
		animation_component.update_animations(velocity.x, state_machine.current_state.name)

	move_and_slide()
	if damageable.isDying: return
	
	if not is_on_floor():
		velocity += get_gravity() * delta

func set_next_state(nextStateName: String):
	if state_machine.current_state != null:
		state_machine.current_state.next_state = state_machine.get_node(nextStateName)
		
func interrupt_state(stateName: String):
	if state_machine.current_state != null:
		state_machine.on_state_interrupt_state(state_machine.get_node(stateName))

func trigger_attack_player():
	if damageable.isDying: return
	interrupt_state("Attack")

func is_player_in_attack_range() -> bool:
	if player_to_follow == null:
		return false
	return attack_range.overlaps_body(player_to_follow)

func on_player_enter(body: Node):
	if damageable.isDying: return
	
	is_following = body != null
	player_to_follow = body
	
	if is_following:
		set_next_state("Chase")
	else:
		set_next_state("Idle")
