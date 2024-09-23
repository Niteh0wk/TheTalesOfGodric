extends HTTPRequest

@onready var register_request: HTTPRequest = $"."
@onready var username_field: TextEdit = $"../Username"
@onready var email_field: TextEdit = $"../Email"
@onready var password_field: TextEdit = $"../Password"
@onready var error_label: Label = $"../Error_Label"

var username : String = ""
var email : String = ""
var password : String



func _on_register_pressed() -> void:
	if username_field.text.is_empty() or email_field.text.is_empty() or password_field.text.is_empty():
		error_label.text = "Please Enter a Username/Email/Password"
	else:
		username = username_field.text
		email = email_field.text
		password = password_field.text.sha256_text()
		
		# Prepare the data to send in the request body
		var request_data = {
			"user_name" : username,
			"email" : email,
			"password" : password,
			"inGameBalance" : 0,
			"item_1_count" : 0,
			"item_2_count" : 0,
			"item_3_count" : 0
		}
		
		# Convert the dictionary to JSON format
		var json_data = JSON.stringify(request_data)
		
		# Send the POST request to the createUser API method
		var headers = [
			"Content-Type:application/json" # Important: Tell the server we're sending JSON
		]
		
		register_request.request("http://localhost:8080/api/users/createUser", headers, HTTPClient.METHOD_POST, json_data)

func _on_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	var response: String = body.get_string_from_utf8()
	
	if response_code == 500:
		error_label.text = response
	elif response_code == 201:
		print("User created successfully!")
		get_tree().change_scene_to_file("res://scenes/login.tscn")
	else:
		print("Failed to create user. Error:" , response_code)
		print("Response:", response)
