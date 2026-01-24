extends Button

func _on_button_up() -> void:
	Global.game_controller.change_gui_scene(
		"res://UI/character_selection.tscn",
		false,
		false
	)
