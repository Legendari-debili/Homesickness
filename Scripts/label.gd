extends Label

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	text = "EP: " + str(Globals.ep) + "\nLevels: " + str(Globals.level_count)
