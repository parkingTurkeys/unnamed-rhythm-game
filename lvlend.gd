extends Label
@onready var textfield = %Score.text

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%Score.text = GlobalData.score


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
