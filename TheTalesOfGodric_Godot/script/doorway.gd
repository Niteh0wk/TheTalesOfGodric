extends Area2D

@export var next_scene_path : String = ""
@export var entry_point_name: String = ""

var player_in_area = false
var player_node = null

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))

func _on_body_entered(body):
	if body.is_in_group("Player"):
		player_in_area = true
		player_node = body
		

func _on_body_exited(body):
	if body.is_in_group("Player"):
		player_in_area = false
		player_node = null
		
		
func _process(delta):
	if player_in_area and Input.is_action_just_pressed("interact"):
		if player_node:
			save_entry_point_and_change_scene()

func save_entry_point_and_change_scene():
	GameState.set_player_entry(entry_point_name)
	GameState.save_player_state(player_node.global_position, get_tree().current_scene.scene_file_path)
	change_scene()

func change_scene():
	if next_scene_path != "":
		get_tree().change_scene_to_file(next_scene_path)
	else:
		print("No scene path set for this door!")
