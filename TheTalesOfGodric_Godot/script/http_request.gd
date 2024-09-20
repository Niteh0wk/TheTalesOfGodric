extends HTTPRequest

@onready var http_request: HTTPRequest = $"."

func _on_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	var response: String = body.get_string_from_utf8()
	
	var json_parser = JSON.new()
	
	json_parser.parse(response)
	
	var user_data = json_parser.data
	
	print(user_data)


func _on_button_pressed() -> void:
	http_request.request("http://localhost:8080/api/users/66ebcb1be9773fe6ca3e28cc")
