class_name AnimationComponent
extends Node

@export_subgroup("Nodes")
@export var sprite: AnimatedSprite2D
@onready var body: CharacterBody2D = get_parent()

signal facing_direction_changed(facing_right : bool)

func _on_ready():
	handle_horizontal_flip(-1)

func handle_horizontal_flip(move_direction: float) -> void:
	if move_direction == 0:
		return

	sprite.flip_h = false if move_direction > 0 else true
	
	emit_signal("facing_direction_changed", !sprite.flip_h)
	
func handle_move_animation(move_direction: float) -> void:
	handle_horizontal_flip(move_direction)
	
	if move_direction != 0:
		sprite.play('run')
	else:
		sprite.play('idle')
		
func play_jump_animation() -> void:
	sprite.play('jump')

func handle_jump_animation(is_jumping: bool, is_falling: bool) -> void:
	if is_jumping:
		sprite.play('jump')
	elif is_falling:
		sprite.play('fall')
