extends Node

var player_position : Vector2 = Vector2.ZERO
var current_scene : String = ""
var current_entry_point : String = ""
var should_set_position : bool = false
var in_dialogue = false
var in_inventory = false
var in_menu = false

var entry_points = {
	"H1Entry" : Vector2(105, 102.9974) ,
	"H1Exit" : Vector2(-213.5391, -1144.995)
}

func set_player_entry(entry_point: String):
	current_entry_point = entry_point
	should_set_position = true
	print("Entry point set to:", current_entry_point)

func save_player_state(player_position : Vector2, scene_path : String):
	self.player_position = player_position
	self.current_scene = scene_path

func set_player_position() -> Vector2:
	if should_set_position and current_entry_point != "":
		if current_entry_point in entry_points:
			print("Entry point found:", current_entry_point)
			should_set_position = false
			return entry_points[current_entry_point]
		else:
			print("Entry point not found:", current_entry_point)
	should_set_position = false
	print("Returning saved player position:", player_position)
	return player_position if player_position != Vector2.ZERO else Vector2(0,0)

func set_player_dialogue_state(dialogue_bool : bool):
	in_dialogue = dialogue_bool

func get_player_dialogue_state():
	return in_dialogue
	
func set_player_inventory_state(inventory_bool : bool):
	in_inventory = inventory_bool
	
func get_player_inventory_state():
	return in_inventory
	
func set_player_menu_state(menu_bool : bool):
	in_menu = menu_bool

func get_player_menu_state():
	return in_menu
