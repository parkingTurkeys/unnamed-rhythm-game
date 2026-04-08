extends Label
var NOTE_SPEED = GlobalData.NOTE_SPEED
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text = GlobalData.note_to_spawn


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	set_position(Vector2(position.x + NOTE_SPEED*(delta/0.03), position.y))
	if position.x > 1200:
		queue_free()
	elif position.x > 0:
		GlobalData.start_yet = true;
	# print(delta)
