extends Control

func _on_back_to_register_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/register.tscn")
