class_name GravityComponent
extends Node

@export_subgroup("Settings")
@export var gravity: float = 2500.0


var is_falling: bool = false

func handle_gravity(body: CharacterBody2D, delta: float) -> void:
	if not body.is_on_floor():
		body.velocity.y += gravity * delta
	
	is_falling = body.velocity.y > 0 and not body.is_on_floor()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
