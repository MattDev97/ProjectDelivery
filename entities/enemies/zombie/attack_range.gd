extends Area2D

var player_in_range : bool = false
signal on_player_enter()

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		player_in_range = true
		emit_signal("on_player_enter")
		
func _on_body_exit(body: Node2D) -> void:
	if body is Player:
		player_in_range = false
