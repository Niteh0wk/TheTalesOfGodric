extends HTTPRequest

@onready var shop_request: HTTPRequest = $"."

@onready var prize_item_1: Label = $"../Shop_Sprite/Item_1/Prize_Item_1"
@onready var prize_item_2: Label = $"../Shop_Sprite/Item_2/Prize_Item_2"
@onready var prize_item_3: Label = $"../Shop_Sprite/Item_3/Prize_Item_3"

@onready var buy_item_1: Button = $"../Buy_Item_1"
@onready var buy_item_2: Button = $"../Buy_Item_2"
@onready var buy_item_3: Button = $"../Buy_Item_3"


var item_1_prize = 16
var item_2_prize = 8
var item_3_prize = 32

func _on_buy_item_1_pressed() -> void:
	if int(GameState.get_player_coins()) > item_1_prize:
		prize_item_1.text = "Sold"
		GameState.set_player_coins(GameState.get_player_coins() - item_1_prize)
		update_balance(GameState.get_player_email(), GameState.get_player_coins())
		buy_item_1.disabled = true
		GameState.set_player_item_count(1, GameState.get_player_item_count(1) + 1)
		await await get_tree().create_timer(2).timeout
		update_item_count(GameState.get_player_email(), "item_1", GameState.get_player_item_count(1))

func _on_buy_item_2_pressed() -> void:
	if int(GameState.get_player_coins()) > item_2_prize:
		prize_item_2.text = "Sold"
		GameState.set_player_coins(GameState.get_player_coins() - item_2_prize)
		update_balance(GameState.get_player_email(), GameState.get_player_coins())
		buy_item_2.disabled = true
		GameState.set_player_item_count(2, GameState.get_player_item_count(2) + 1)
		await await get_tree().create_timer(2).timeout
		update_item_count(GameState.get_player_email(), "item_2", GameState.get_player_item_count(2))

func _on_buy_item_3_pressed() -> void:
	if int(GameState.get_player_coins()) > item_3_prize:
		prize_item_3.text = "Sold"
		GameState.set_player_coins(GameState.get_player_coins() - item_3_prize)
		update_balance(GameState.get_player_email(), GameState.get_player_coins())
		buy_item_3.disabled = true
		GameState.set_player_item_count(3, GameState.get_player_item_count(3) + 1)
		await await get_tree().create_timer(2).timeout
		update_item_count(GameState.get_player_email(), "item_3", GameState.get_player_item_count(3))

func update_balance(email : String, new_balance : int):
	var url = "http://localhost:8080/api/users/" + email + "/updateBalance"
	
	var update_data = {
		"newBalance" = new_balance
	}
	
	var json_string = JSON.stringify(update_data)
	
	var headers = ["Content-Type:application/json"]
	
	print("URL: ", url)
	print("Request body: ", json_string)
	shop_request.request(url, headers, HTTPClient.METHOD_PUT, json_string)

func update_item_count(email : String, item_string : String, item_count : int):
	var url = "http://localhost:8080/api/users/" + email + "/updateItemCount"
	
	var update_data = {
		"item" = item_string,
		"newItemCount" = item_count
	}
	
	var json_string = JSON.stringify(update_data)
	
	var headers = ["Content-Type:application/json"]
	
	print("URL: ", url)
	print("Request body: ", json_string)
	shop_request.request(url, headers, HTTPClient.METHOD_PUT, json_string)

func _on_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	print("Result: ", result)
	print("Response Code: ", response_code)
	print("Response Body: ", body.get_string_from_utf8())



# I made an email encoder so that the @ symbol was turned into %40 but i after some testing i found out i dont need it so i just left it here
func url_encode(text : String) -> String:
	var encoded = ""
	for char in text:
		var utf8_buffer = char.to_utf8_buffer()
		var code = int(utf8_buffer[0])
		if (code >= 48 and code <= 57) or (code >= 65 and code <= 90) or (code >= 97 and code <= 122) or char in ["-", "_", ".","~"]:
			# Characters that don't need encoding (alphanumeric and safe characters)
			encoded += char
		else:
			# Convert special characters to %XX format
			encoded += "%" + to_hex(code)
	return encoded
	
func to_hex(value : int) -> String:
	var hex = "0123456789ABCDEF"
	return hex[(value >> 4) & 0xF] + hex[value & 0xF]
