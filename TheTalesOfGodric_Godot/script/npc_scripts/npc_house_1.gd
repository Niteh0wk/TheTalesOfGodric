extends Area2D

var player_in_area = false

@onready var dialogue: Control = $"../../Dialogue"
@onready var press_e: AnimatedSprite2D = $"../Press_E2"
@onready var shop: Control = $"../../Player/Shop"

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))

func _on_body_entered(body):
	if body.is_in_group("Player"):
		player_in_area = true

func _on_body_exited(body):
	if body.is_in_group("Player"):
		player_in_area = false

func _process(delta: float) -> void:
	if player_in_area and GameState.get_player_dialogue_state() != true:
		press_e.visible = true
		if Input.is_action_just_pressed("interact"):
			# Here comes the script for the first npc interactions/dialog
			press_e.visible = false
			GameState.set_player_dialogue_state(true)
	else:
		press_e.visible = false
	
	if GameState.get_player_dialogue_state() == true:
		dialogue.visible = true
	else: 
		dialogue.visible = false
		
	if GameState.get_player_shop_state() == true:
		shop.visible = true
	else:
		shop.visible = false
