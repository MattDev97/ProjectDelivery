extends Button

func _on_button_up() -> void:
	Global.game_controller.change_gui_scene(
		"res://ui/char_select/character_selection.tscn",
		false,
		false
	)
