extends CharacterBody2D

@onready var zombie: AnimatedSprite2D = $Zombie
@onready var state_machine: CharacterStateMachine = $CharacterStateMachine

@export var starting_move_direction : Vector2 = Vector2.LEFT
@export var movement_speed : float = 30
@export var hit_state : State
@export var vision : Area2D

@export var damageable : Damageable

var is_following = false
var player_to_follow : Player

func _ready() -> void:
	vision.connect("on_player_enter", on_player_enter)

func _physics_process(delta: float) -> void:
	if damageable.isDying: return
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	if is_following && player_to_follow != null:
		
		# 1. Calculate the raw difference in positions
		var difference_x = player_to_follow.global_position.x - global_position.x
		
		# 2. Convert that to a simple -1, 0, or 1 direction
		# We use Vector2(x, 0) because your logic expects a Vector2 'direction' variable
		var direction : Vector2 = Vector2(sign(difference_x), 0)

		# Optional: Stop moving if we are very close (e.g., within 20 pixels) to prevent jittering
		if abs(difference_x) < 20:
			direction = Vector2.ZERO

		if direction && state_machine.check_if_can_move():
			velocity.x = direction.x * movement_speed
			set_next_state('Walk')
		elif state_machine.current_state != hit_state:
			velocity.x = move_toward(velocity.x, 0, movement_speed)

		# If we aren't moving, don't update sprite flip
		if direction.x == 0:
			# If you want to keep sliding while stopping, you can keep move_and_slide outside
			# But here we return early to skip the flip logic
			move_and_slide() # Ensure gravity still applies even if standing still!
			set_next_state('Idle')
			return
		
		# Flip logic
		zombie.flip_h = false if direction.x > 0 else true
	else:
		velocity.x = 0
		set_next_state('Idle')
	move_and_slide()

func set_next_state(nextStateName : String):
	if state_machine.current_state != null:
		state_machine.current_state.next_state = state_machine.get_node(nextStateName)

func on_player_enter(body : Node):
	is_following = body != null
	player_to_follow = body
