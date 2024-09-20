extends HTTPRequest

@onready var login_request: HTTPRequest = $"."

@onready var password_field: TextEdit = $"../Password"
@onready var email_field: TextEdit = $"../Email"


var email = ""
var password

func _on_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	var response: String = body.get_string_from_utf8()
	
	var json_parser = JSON.new()
	
	json_parser.parse(response)
	
	var user_data = json_parser.data
	
	if "password" in user_data:
		var stored_passsword = user_data["password"]
		if password == stored_passsword:
			print(user_data)

func _on_login_pressed() -> void:
	email = email_field.text
	password = password_field.text.sha256_text()
	login_request.request("http://localhost:8080/api/users/email?email=" + email)
