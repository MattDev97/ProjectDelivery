extends Area2D

@export var interaction_sprite : TextureRect
var can_interact = false

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		on_player_enter(body)


func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		on_player_enter(null)

func on_player_enter(body) -> void:
	can_interact = body != null
	interaction_sprite.visible = can_interact
	
func _input(event) -> void:
	if Input.is_action_just_pressed("interact") && can_interact:
		Global.game_controller.complete_objective("order_andy_1")
