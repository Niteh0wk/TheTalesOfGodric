extends HTTPRequest

@onready var register_request: HTTPRequest = $"."
@onready var username_field: TextEdit = $"../Username"
@onready var email_field: TextEdit = $"../Email"
@onready var password_field: TextEdit = $"../Password"

var username : String = ""
var email : String = ""
var password : String

func _on_register_pressed() -> void:
	username = username_field.text
	email = email_field.text
	password = password_field.text.sha256_text()
	
	# Prepare the data to send in the request body
	var request_data = {
		"user_name" : username,
		"email" : email,
		"password" : password,
		"inGameBalance" : 0
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
	
	if response_code == 200:
		print("User created successfully!")
	else:
		print("Failed to create user. Error:" , response_code)
		print("Response:", response)
