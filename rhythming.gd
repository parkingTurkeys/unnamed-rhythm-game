extends Node2D
# later, this will be a user:// path probably :3
var map_loc = "res://maps/test.txt"
@onready var metronome = %metronome
@onready var acc_timer = %acc_timeout
var actions = ["h", "j", "k", "l", "a", "d", "w", "s"]
var beatmap
var note = preload("res://rhythm_display.tscn")
var all_clicks = []
var current_note_clicks = []
var current_acc_clicks = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	beatmap = file_to_array(map_loc)
	print(beatmap)
	metronome.start(60.0/float(beatmap.bpm))
	print(metronome)
	acc_timer.start((60.0/float(beatmap.bpm))/float(beatmap.acc))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	add_keys_pressed()

func file_to_array(map_loc_yes):
	var beat_array = []
	var file = FileAccess.open(map_loc_yes, FileAccess.READ)
	var content = file.get_as_text()
	var map_settings = content.split("START")[0].split(";")
	var bpm
	var len
	var acc
	print(map_settings)
	for i in map_settings:
		var settingy_thing = i.split(":")
		match settingy_thing[0]:
			"bpm":
				bpm = settingy_thing[1]
			"len":
				len = settingy_thing[1]
			"acc":
				acc = settingy_thing[1]
	var map_body = content.split("START")[1].split(",")
	for i in map_body:
		if actions.has(i):
			# it's a thing to do
			beat_array.append(i)
		else:
			# it's a number. probably.
			if i.is_valid_int():
				# Yay
				for n in range(0, i.to_int()):
					beat_array.append("R")
			else:
				print("your beatmap is broken :(")
				return {"map":["w", "w", "s", "s", "a", "d", "a", "d", "h", "j"], "bpm": 20, "len": 10, "acc":30}
	print(beat_array)
	return {"map":beat_array, "bpm": bpm, "len": len, "acc": acc}


func _on_metronome_timeout() -> void:
	check_notes()
	if beatmap.map != []:
		print("VOTE YURI PARTY")
		var curr_note = beatmap.map[0]
		beatmap.map.remove_at(0)
		GlobalData.current_note = curr_note
		GlobalData.next_note = beatmap.map[0] # since we removed the current note :4
		if curr_note == "R":
			pass
		else:
			
			var instance = note.instantiate()
			add_child(instance)

func add_keys_pressed() -> void:
	var curr_clicks = []
	if Input.is_action_just_pressed("up"):
		curr_clicks.append("w")
	elif Input.is_action_just_pressed("down"):
		curr_clicks.append("s")
	elif Input.is_action_just_pressed("left"):
		curr_clicks.append("a")
	elif Input.is_action_just_pressed("right"):
		curr_clicks.append("d")
	elif Input.is_action_just_pressed("atk"):
		curr_clicks.append("k")
	elif Input.is_action_just_pressed("rhythm"):
		curr_clicks.append("l")
	elif Input.is_action_just_pressed("dash"):
		curr_clicks.append("j")
	elif Input.is_action_just_pressed("jump"):
		curr_clicks.append("h")
	current_acc_clicks.append(curr_clicks)

func check_notes():
	var current_note_found
	var next_note_found
	var accs_lost_for_next_note
	var accs_lost_for_curr_note
	if (GlobalData.current_note != "R"):
		current_note_found = false; 
	else:  
		current_note_found = true
		accs_lost_for_curr_note = 0
	if (GlobalData.next_note != "R"):
		next_note_found = false; 
	else:  
		next_note_found = true # NOTE: U HAVE TO CHECK IF THE next NOTE WAS ALREADY FOUND AT SOME POINT
		accs_lost_for_next_note = 0
	for i in range(current_note_clicks.size()):
		if (current_note_clicks[i].is_empty() != true):
			for n in range(current_note_clicks[i].size()):
				if (current_note_clicks[i][n].has(GlobalData.current_note) && current_note_found == false):
					current_note_found = true
					accs_lost_for_curr_note = n
				if (current_note_clicks[i][n].has(GlobalData.next_note) && next_note_found == false):
					next_note_found = true
					accs_lost_for_next_note = current_acc_clicks.size() - n
	if (current_note_found == false):
		accs_lost_for_curr_note = "M"
	if (next_note_found == false):
		accs_lost_for_next_note = "M"
	print(accs_lost_for_curr_note)
	all_clicks.append(current_note_clicks)
	current_note_clicks = []


func _on_acc_timeout() -> void:
	# here we add all the notes ehe and like check yk. so the current_acc_clicks has everything that should be checked here ehe
	current_note_clicks.append(current_acc_clicks) # adding those! for liek good yes ehe :3
	current_acc_clicks = []
	# get the last and next note uwu
	# i just realized i put these in the wrong place
	#var current_note_found
	#var next_note_found
	#var accs_lost_for_next_note
	#var accs_lost_for_curr_note
	#if (GlobalData.current_note != "R"):
		#current_note_found = false; 
	#else:  
		#current_note_found = true
		#accs_lost_for_curr_note = 0
	#if (GlobalData.next_note != "R"):
		#next_note_found = false; 
	#else:  
		#next_note_found = true # NOTE: U HAVE TO CHECK IF THE next NOTE WAS ALREADY FOUND AT SOME POINT
		#accs_lost_for_next_note = 0
	#for i in range(current_acc_clicks.size()):
		#if (current_acc_clicks[i].is_empty() != true):
			#for n in range(current_acc_clicks[i].size()):
				#if (n == GlobalData.current_note && current_note_found == false):
					#current_note_found = true
					#accs_lost_for_curr_note = i
				#if (n == GlobalData.next_note && next_note_found == false):
					#next_note_found = true
					#accs_lost_for_next_note = current_acc_clicks.size() - i
	#if (current_note_found == false):
		#accs_lost_for_curr_note = "M"
	#if (next_note_found == false):
		#accs_lost_for_next_note = "M"
