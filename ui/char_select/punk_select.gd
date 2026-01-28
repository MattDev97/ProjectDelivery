extends Button

func _on_button_up() -> void:
	Global.game_controller.select_character('Woodcutter')
	Global.game_controller.change_gui_scene(
		"res://ui/player_ui/player_ui.tscn",
		true,
		false
	)
	
	Global.game_controller.change_2d_scene(
		"res://TestLevel.tscn",
		false,
		false
	)
	
	Global.game_controller.background_manager.load_background("green_hill")
