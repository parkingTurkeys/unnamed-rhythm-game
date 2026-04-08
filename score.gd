extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (GlobalData.note_accuracies.size() - 1 >= 0): 
		GlobalData.score = String(GlobalData.note_accuracies[GlobalData.note_accuracies.size() - 1])
		text = GlobalData.score
	%curr_note.text = GlobalData.current_note
	%next_note.text = GlobalData.next_note
