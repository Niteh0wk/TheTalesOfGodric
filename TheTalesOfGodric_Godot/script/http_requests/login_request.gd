extends HTTPRequest

@onready var login_request: HTTPRequest = $"."

@onready var password_field: TextEdit = $"../Password"
@onready var email_field: TextEdit = $"../Email"
@onready var error_label: Label = $"../Error_Label"


var email : String = ""
var password : String

func _on_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	var response: String = body.get_string_from_utf8()
	
	var json_parser = JSON.new()
	
	json_parser.parse(response)
	
	var user_data = json_parser.data
	
	if response_code == 404:
		error_label.text = "Wrong Email/Password"
	else:
		if "password" in user_data:
			var stored_passsword = user_data["password"]
			if password == stored_passsword:
				# Sets the username in the global script so that we can access it in the player script
				GameState.set_player_username(user_data["user_name"])
				# Set the players coin count
				GameState.set_player_coins(str(user_data["inGameBalance"]))
				
				get_tree().change_scene_to_file("res://scenes/menu.tscn")
			else:
				error_label.text = "Wrong Email/Password"

func _on_login_pressed() -> void:
	if email_field.text.is_empty() and password_field.text.is_empty():
		pass
	else:
		email = email_field.text
		password = password_field.text.sha256_text()
		login_request.request("http://localhost:8080/api/users/email?email=" + email)
