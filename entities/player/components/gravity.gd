# scenes/components/gravity_component.gd
class_name GravityComponent
extends Node

@export_subgroup("Settings")
@export var gravity: float = 2000.0

# The component finds its own parent!
@onready var body: CharacterBody2D = get_parent().get_parent()

func _physics_process(delta: float) -> void:
	# Now you don't need to call this manually in Player.gd! 
	# The component does the work itself.
	if not body.is_on_floor():
		body.velocity.y += gravity * delta
