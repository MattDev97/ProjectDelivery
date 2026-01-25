extends State

class_name HitState

@export var damageable : Damageable
@export var dead_state : State
@export var character_state_machine : CharacterStateMachine
@export var animated_sprite : AnimatedSprite2D
@export var knockback_speed : float = 100.0
@export var return_state : State

@onready var timer : Timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	damageable.connect("on_hit", on_damageable_hit)
	
	if not animated_sprite.animation_finished.is_connected(_on_animation_finished):
		animated_sprite.animation_finished.connect(_on_animation_finished)
		
func on_enter():
	timer.start()

func on_damageable_hit(node : Node, damage_amount : int, knockback_direction: Vector2):
	if(damageable.health > 0):
		
		character.velocity = knockback_speed * knockback_direction
		emit_signal("interrupt_state", self)
		animated_sprite.play('hurt')
	else:
		emit_signal("interrupt_state", dead_state)
		animated_sprite.play('die')

func _on_animation_finished():
	# Automatically go back to Ground (which will switch to Idle or Run)
	character.set_next_state('Walk')
	
func on_exit():
	character.velocity = Vector2.ZERO


func _on_timer_timeout() -> void:
	next_state = return_state
	pass # Replace with function body.
