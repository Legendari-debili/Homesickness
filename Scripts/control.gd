extends Control

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/game.tscn") #GO TO THE FUCKING GAME AND FUCKING PLAY

func _on_button_exit_pressed() -> void:
	get_tree().quit() # QUIT IT

func _on_button_3_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/MainMenu/scripts.tscn")
