extends Area2D


func _on_body_entered(body) -> void:
	if !(Globals.touched_end and body.name == "Player"): return
	
	var win_text = body.find_child("Win")
	var win_sound = body.find_child("WinAudio")
	
	win_sound.play()
	win_text.visible = true
	get_tree().paused = true
	
	await get_tree().create_timer(5).timeout
	
	get_tree().paused = false
	win_text.visible = false
	get_tree().call_deferred("reload_current_scene")
	Globals.reset_global_variables()
	Globals.level_count += 1


func _ready() -> void:
	body_entered.connect(_on_body_entered)
