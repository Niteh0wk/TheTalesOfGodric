extends Control

@onready var login_request: HTTPRequest = $login_request

var email = ""
var password

func _on_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	var response: String = body.get_string_from_utf8()
	
	var json_parser = JSON.new()
	
	json_parser.parse(response)
	
	var user_data = json_parser.data
	
	print(user_data)



func _on_register_pressed() -> void:
	email = $Email.text
	password = $Password.text
	login_request.request("http://localhost:8080/api/users/email?email=" , email)
	
	#"http://localhost:8080/api/users/66ebcb1be9773fe6ca3e28cc"
