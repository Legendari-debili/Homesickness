extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass # pass DUH
	


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Objects/game.tscn") #GO TO THE FUCKING GAME AND FUCKING PLAY
	
	   


func _on_button_exit_pressed() -> void:
	get_tree().quit() # QUIT IT


func _on_button_3_pressed() -> void:
	get_tree().change_scene_to_file("res://Levels/scripts.tscn")
