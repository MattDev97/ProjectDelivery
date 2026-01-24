extends Button

func _on_button_up() -> void:
	Global.game_controller.select_character('Punk')
	Global.game_controller.change_gui_scene(
		"res://UI/player_ui.tscn",
		true,
		false
	)
	
	Global.game_controller.change_2d_scene(
		"res://Main.tscn",
		false,
		false
	)
