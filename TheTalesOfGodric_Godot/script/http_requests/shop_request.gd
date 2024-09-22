extends HTTPRequest

@onready var shop_request: HTTPRequest = $"."

@onready var prize_item_1: Label = $"../Shop_Sprite/Item_1/Prize_Item_1"
@onready var prize_item_2: Label = $"../Shop_Sprite/Item_2/Prize_Item_2"
@onready var prize_item_3: Label = $"../Shop_Sprite/Item_3/Prize_Item_3"

func _on_buy_item_1_pressed() -> void:
	if GameState.get_player_coins() > 16:
		prize_item_1.text = "Sold"
		

func _on_buy_item_2_pressed() -> void:
	prize_item_2.text = "Sold"

func _on_buy_item_3_pressed() -> void:
	prize_item_3.text = "Sold"
	
