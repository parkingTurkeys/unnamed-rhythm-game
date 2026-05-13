extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	loadchar("res://player.tscn");
	loadlevel("res://levels/lvl_test.tscn");


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func loadchar(path: String):
	var player = load(path).instantiate();
	add_child(player);
	player.position.x = 500;
	return player;

func loadlevel(path: String):
	var level = load(path).instantiate();
	add_child(level);
	return level;
