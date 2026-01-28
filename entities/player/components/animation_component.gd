class_name AnimationComponent
extends Node

@export_subgroup("Nodes")
@onready var sprite : Sprite2D = $"../Animation/Sprite2D"
@onready var body: CharacterBody2D = get_parent()
@export var animation_tree: AnimationTree
@onready var animation_tree_playback: AnimationNodeStateMachinePlayback = animation_tree["parameters/playback"]

signal facing_direction_changed(facing_right : bool)

func _on_ready():
	animation_tree.active = true
	handle_horizontal_flip(-1)

func handle_horizontal_flip(move_direction: float) -> void:
	if move_direction == 0:
		return
		
	sprite.flip_h = false if move_direction > 0 else true
	
	emit_signal("facing_direction_changed", !sprite.flip_h)
	
func handle_move_animation(move_direction: float) -> void:
	handle_horizontal_flip(move_direction)
	
	if move_direction != 0:
		animation_tree.set("parameters/move/blend_position", move_direction)
	else:
		animation_tree.set("parameters/move/blend_position", 0)
		
func handle_travel_animation(anim_name : String):
	animation_tree_playback.travel(anim_name)

func handle_attack_animation() -> void:
	animation_tree_playback.travel("attack_1")
