extends Area2D

signal on_player_enter(node : Node)

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		emit_signal("on_player_enter", body)


func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		emit_signal("on_player_enter", null)
