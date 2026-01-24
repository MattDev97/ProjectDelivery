class_name AnimationComponent
extends Node

@export_subgroup("Nodes")
@export var sprite: AnimatedSprite2D
@onready var body: CharacterBody2D = get_parent()

func handle_move_animation(move_direction: float) -> void:
	var body_scale = -1 if move_direction > 0 else 1
	print('body_scale: ' + str(body_scale))
	print('body.scale.x: ' + str(body.scale.x))
	if(body.scale.x != body_scale):
		body.scale.x *= body_scale
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
