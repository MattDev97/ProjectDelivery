extends CharacterBody2D

@onready var zombie: AnimatedSprite2D = $Zombie
@onready var state_machine: CharacterStateMachine = $CharacterStateMachine

@export var starting_move_direction : Vector2 = Vector2.LEFT
@export var movement_speed : float = 30
@export var hit_state : State

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#var direction := Input.get_axis("ui_left", "ui_right")
	var direction : Vector2 = starting_move_direction 
	if direction && state_machine.check_if_can_move():
		velocity.x = direction.x * movement_speed
	elif state_machine.current_state != hit_state:
		velocity.x = move_toward(velocity.x, 0, movement_speed)

	if direction.x == 0:
		return
	
	zombie.flip_h = false if direction.x > 0 else true
	move_and_slide()

func set_next_state(nextStateName : String):
	if state_machine.current_state != null:
		state_machine.current_state.next_state = state_machine.get_node(nextStateName)
