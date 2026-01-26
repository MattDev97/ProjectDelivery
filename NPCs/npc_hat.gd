extends CharacterBody2D

@export var interaction_zone : Area2D
@export var interaction_sprite : TextureRect
var can_interact = false

func _ready() -> void:
	interaction_zone.connect("on_player_enter", on_player_enter)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	move_and_slide()

func on_player_enter(body) -> void:
	can_interact = body != null
	interaction_sprite.visible = can_interact
	
func _input(event) -> void:
	if Input.is_action_just_pressed("interact") && can_interact:
		Global.game_controller.complete_objective("order_andy_2")
