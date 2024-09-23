extends Control

@onready var prize_item_1: Label = $Shop_Sprite/Item_1/Prize_Item_1
@onready var prize_item_2: Label = $Shop_Sprite/Item_2/Prize_Item_2
@onready var prize_item_3: Label = $Shop_Sprite/Item_3/Prize_Item_3
@onready var coins: Label = $Shop_Sprite/Current_Coins/Coins

func _on_x_2_pressed() -> void:
	GameState.set_player_shop_state(false)

func _process(delta: float) -> void:
	coins.text = str(GameState.get_player_coins())
