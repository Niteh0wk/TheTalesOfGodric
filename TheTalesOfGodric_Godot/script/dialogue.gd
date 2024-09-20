extends Control

@export var file_path : String

var dialogue = []
var current_dialogue_id = 0

func _ready() -> void:
	start()
	
func start():
	dialogue = load_dialogue()
	current_dialogue_id = -1
	next_script()
	
func load_dialogue():
	var file = FileAccess.open(file_path, FileAccess.READ)
	var content = JSON.parse_string(file.get_as_text())
	return content
	
func _input(event):
	if event.is_action_pressed("left_click"):
		next_script()
	
func next_script():
	current_dialogue_id += 1
	if current_dialogue_id >= len(dialogue):
		GameState.set_player_dialogue_state(false)
		return
	
	$Dialogue_Field/Name.text = dialogue[current_dialogue_id]['name']
	$Dialogue_Field/Speech_Text.text = dialogue[current_dialogue_id]['text']
