extends Control

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/game.tscn")
	Globals.in_game = true

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_credits_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/MainMenu/credits.tscn")

func _process(_delta: float) -> void:
	if Input.is_action_pressed("pause"):
		get_tree().quit()
