extends CharacterBody2D

@onready var sprite = $Sprite
@onready var inventory_sprite: Sprite2D = $Inventory
@onready var background_darkening: ColorRect = $PlayerCamera/BackgroundDarkening
@onready var ingame_menu: Control = $ingame_menu
@onready var username_label: Label = $Username
@onready var coin_count: Label = $Inventory/Coin/Coin_Count

const SPEED = 70.0
const SPRINT_MULTIPLIER = 1.5
var inventory_toggle = true
var menu_toggle = true
var can_move = true

func _ready():
	var new_position = GameState.set_player_position()
	if new_position != Vector2.ZERO:
		global_position = new_position
		print("Player position set to:" , global_position)
	else:
		print("Using initial position set in the editor:", global_position)
	# Set the username for the player
	username_label.text = GameState.get_player_username()
	coin_count.text = GameState.get_player_coins()
	

func _physics_process(delta):
	var left = Input.is_action_pressed("left")
	var right = Input.is_action_pressed("right")
	var up = Input.is_action_pressed("up")
	var down = Input.is_action_pressed("down")
	var sprint = Input.is_action_pressed("sprint")
	var escape = Input.is_action_just_pressed("escape")
	var inventory = Input.is_action_just_pressed("inventory")
	
	if inventory and ingame_menu.visible == false and GameState.get_player_shop_state() == false:
		inventory_sprite.visible = inventory_toggle
		background_darkening.visible = inventory_toggle
		username_label.visible = !inventory_toggle
		inventory_toggle = !inventory_toggle
		print("The inventory_toggle is:" , inventory_toggle)
		GameState.set_player_inventory_state(!inventory_toggle)
		
		
	if escape and inventory_sprite.visible == false and GameState.get_player_shop_state() == false:
		ingame_menu.visible = menu_toggle
		background_darkening.visible = menu_toggle
		username_label.visible = !menu_toggle
		menu_toggle = !menu_toggle
		print("The menu_toggle is:", menu_toggle)
		GameState.set_player_menu_state(!menu_toggle)
		
	if GameState.get_player_dialogue_state() == true:
		can_move = false
	elif GameState.get_player_inventory_state() == true:
		can_move = false
	elif GameState.get_player_menu_state() == true:
		can_move = false
	elif GameState.get_player_shop_state() == true:
		can_move = false
	else:
		can_move = true
	
	if can_move:
		var direction = Input.get_vector("left", "right", "up", "down")
		var speed = SPEED
		
		if sprint:
			speed *= SPRINT_MULTIPLIER
		
		velocity = direction * speed
		
		if left && !sprint:
			sprite.play("walk_left")
			sprite.flip_h = true
		elif left && sprint:
			sprite.play("run_left")
			sprite.flip_h = true
		elif right && !sprint:
			sprite.play("walk_right")
			sprite.flip_h = false
		elif right && sprint:
			sprite.play("run_right")
			sprite.flip_h = false
		elif down && !sprint:
			sprite.play("walk_down")
		elif down && sprint:
			sprite.play("run_down")
		elif up && !sprint:
			sprite.play("walk_up")
		elif up && sprint:
			sprite.play("run_up")
		else:
			sprite.play("idle_front")
			
		move_and_slide()
