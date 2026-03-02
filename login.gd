extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_submit_pressed() -> void:
	$HTTPRequest.request_completed.connect(_on_request_completed)
	# $HTTPRequest.request(GlobalData.api_route + "login.php")
	var url = GlobalData.api_route + "login.php/"
	var data_to_send = "{'username':'" + %name_input.text + "','password':'" + %password_input.text + "'}"
	var json = JSON.stringify(data_to_send)
	var headers = ["Content-Type: application/json"]
	$HTTPRequest.request(url, headers, HTTPClient.METHOD_POST, json)

func _on_request_completed(result, response_code, headers, body):
		print(body.get_string_from_utf8())
		var json = JSON.parse_string('{"success":false}')
		if (json["success"]):
			print(json["id"])
		else:
			print("failed srry")
