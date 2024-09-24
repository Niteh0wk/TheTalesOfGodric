extends CharacterBody2D

@onready var sprite = $Sprite
@onready var inventory_sprite: Sprite2D = $Inventory
@onready var background_darkening: ColorRect = $PlayerCamera/BackgroundDarkening
@onready var ingame_menu: Control = $ingame_menu
@onready var username_label: Label = $Username
@onready var coin_count: Label = $Inventory/Coin/Coin_Count
@onready var skeleton: CharacterBody2D = $"../Skeleton"
@onready var count_1: Label = $Inventory/Inventory_Grid/Item_1/Count_1
@onready var count_2: Label = $Inventory/Inventory_Grid/Item_2/Count_2
@onready var count_3: Label = $Inventory/Inventory_Grid/Item_3/Count_3
@onready var item_1: Sprite2D = $Inventory/Inventory_Grid/Item_1
@onready var item_2: Sprite2D = $Inventory/Inventory_Grid/Item_2
@onready var item_3: Sprite2D = $Inventory/Inventory_Grid/Item_3
@onready var health_bar_progress: ProgressBar = $PlayerCamera/Health_Bar_Progress
@onready var health_bar: Sprite2D = $PlayerCamera/Health_Bar

const SPEED = 70.0
const SPRINT_MULTIPLIER = 1.5
var inventory_toggle = true
var menu_toggle = true
var can_move = true
var is_attacking = false
var enemy_in_range = false

func _ready():
	var new_position = GameState.set_player_position()
	if new_position != Vector2.ZERO:
		global_position = new_position
		print("Player position set to:" , global_position)
	else:
		print("Using initial position set in the editor:", global_position)
	# Set the username for the player
	username_label.text = GameState.get_player_username()
	
	

func _physics_process(delta):
	var left = Input.is_action_pressed("left")
	var right = Input.is_action_pressed("right")
	var up = Input.is_action_pressed("up")
	var down = Input.is_action_pressed("down")
	var sprint = Input.is_action_pressed("sprint")
	var escape = Input.is_action_just_pressed("escape")
	var inventory = Input.is_action_just_pressed("inventory")
	var attack = Input.is_action_pressed("attack")
	
	coin_count.text = str(GameState.get_player_coins())
	
	if inventory and ingame_menu.visible == false and GameState.get_player_shop_state() == false:
		inventory_sprite.visible = inventory_toggle
		set_background_darkening(inventory_toggle)
		username_label.visible = !inventory_toggle
		health_bar.visible = !inventory_toggle
		health_bar_progress.visible = !inventory_toggle
		inventory_toggle = !inventory_toggle
		print("The inventory_toggle is:" , inventory_toggle)
		GameState.set_player_inventory_state(!inventory_toggle)
		
		
	if escape and inventory_sprite.visible == false and GameState.get_player_shop_state() == false:
		ingame_menu.visible = menu_toggle
		set_background_darkening(menu_toggle)
		username_label.visible = !menu_toggle
		health_bar.visible = !menu_toggle
		health_bar_progress.visible = !menu_toggle
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
	
	if can_move and !is_attacking:
		var direction = Input.get_vector("left", "right", "up", "down")
		var speed = SPEED
		
		if sprint:
			speed *= SPRINT_MULTIPLIER
		
		velocity = direction * speed
		if direction != Vector2.ZERO:
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
		elif attack and !is_attacking:
			sprite.play("attack_right")
			sprite.flip_h = false
			is_attacking = true
			if enemy_in_range:
				skeleton.take_damage()
		elif direction == Vector2.ZERO and !attack:
			sprite.play("idle_front")
			velocity = Vector2.ZERO
			
		move_and_slide()
	
	count_1.text = str(GameState.get_player_item_count(1))
	count_2.text = str(GameState.get_player_item_count(2))
	count_3.text = str(GameState.get_player_item_count(3))
	
	if GameState.get_player_item_count(1) == 0:
		item_1.visible = false
	else:
		item_1.visible = true
		
	if GameState.get_player_item_count(2) == 0:
		item_2.visible = false
	else:
		item_2.visible = true
		
	if GameState.get_player_item_count(3) == 0:
		item_3.visible = false
	else:
		item_3.visible = true

func _on_sprite_animation_finished() -> void:
	if sprite.animation == "attack_right":
		is_attacking = false



func _on_sword_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		enemy_in_range = true
		print("Enemy Entered")

func _on_sword_hitbox_body_exited(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		enemy_in_range = false
		print("Enemy Exited")
		
func set_background_darkening(darkening_bool : bool):
	background_darkening.visible = darkening_bool
