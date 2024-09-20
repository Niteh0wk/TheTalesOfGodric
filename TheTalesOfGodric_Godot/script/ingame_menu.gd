extends Control

signal quit_pressed

func _on_quit_pressed() -> void:
	GameState.set_player_dialogue_state(false)
	GameState.set_player_inventory_state(false)
	GameState.set_player_menu_state(false)
	emit_signal("quit_pressed")
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
