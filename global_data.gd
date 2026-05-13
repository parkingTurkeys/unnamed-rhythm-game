extends Node

# login/api stuff
var password = ""
var api_route = "http://localhost:9000/"

# file data stuff
var data_path = OS.get_executable_path().get_base_dir()


var NOTE_SPEED = 6
var current_note = ""
var next_note = ""
var note_accuracies = []
var start_yet = false
var note_to_spawn = ""
var score = "0"

func _ready():
	if (OS.has_feature("editor")):
		data_path = "D:/projects/unnamed-rhythm-game/game_data" # Change this if you arent me lol
