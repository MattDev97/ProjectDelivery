extends Node
class_name AttackAnimationComponent

@export var animation_tree: AnimationTree
@export var sprite: Node2D # Supports AnimatedSprite2D or Sprite2D

var _playback: AnimationNodeStateMachinePlayback
var _current_state_name: String = ""

func _ready() -> void:
	if animation_tree:
		animation_tree.active = true
		# Access the state machine playback object
		_playback = animation_tree.get("parameters/playback")

func update_animations(direction: float, state_name: String) -> void:
	_handle_facing_direction(direction)

	# Map multiple code states to one animation state
	var anim_state_name = state_name
	if state_name == "Idle" or state_name == "Run" or state_name == "Chase":
		state_name = "move"
		# Set the blend position (0 for idle, 1 for run)
		var blend_val = abs(direction) # Assuming direction is input -1 to 1
		animation_tree.set("parameters/move/blend_position", blend_val)
		
	_handle_state_machine(state_name)

func _handle_facing_direction(direction: float) -> void:
	if direction != 0 and sprite:
		# Check if the node has a flip_h property (AnimatedSprite2D, Sprite2D)
		if "flip_h" in sprite:
			sprite.flip_h = direction < 0
		# Fallback for nodes that use scale (like a Node2D container)
		elif sprite.scale.x != 0:
			sprite.scale.x = abs(sprite.scale.x) * (-1 if direction < 0 else 1)

func _handle_state_machine(state_name: String) -> void:
	if not animation_tree or not _playback:
		return
	
	if _current_state_name != state_name:
		_playback.travel(state_name)
		_current_state_name = state_name
