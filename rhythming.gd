extends Node2D
# later, this will be a user:// path probably :3
var map_loc = "res://maps/test.txt"
@onready var metronome = %metronome
var actions = ["h", "j", "k", "l", "a", "d", "w", "s"]
var beatmap
var note = preload("res://rhythm_display.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	beatmap = file_to_array(map_loc)
	print(beatmap)
	metronome.start(60.0/beatmap.bpm.to_float())
	print(metronome)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func file_to_array(map_loc_yes):
	var beat_array = []
	var file = FileAccess.open(map_loc_yes, FileAccess.READ)
	var content = file.get_as_text()
	var map_settings = content.split("START")[0].split(";")
	var bpm
	var len
	for i in map_settings:
		var settingy_thing = i.split(":")
		match settingy_thing[0]:
			"bpm":
				bpm = settingy_thing[1]
			"len":
				len = settingy_thing[1]
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
				return {"map":["w", "w", "s", "s", "a", "d", "a", "d", "h", "j"], "bpm": 20, "len": 10}
	print(beat_array)
	return {"map":beat_array, "bpm": bpm, "len": len}


func _on_metronome_timeout() -> void:
	if beatmap.map != []:
		print("YURI PARTY")
		var curr_note = beatmap.map[0]
		beatmap.map.remove_at(0)
		if curr_note == "R":
			pass
		else:
			GlobalData.current_note = curr_note
			var instance = note.instantiate()
			add_child(instance)
