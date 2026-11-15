extends Area2D

func _on_body_entered(body) -> void:
	if body.name != "Player" or Globals.touched_end: return
	var end_text = body.find_child("GoHomeDucker")
	var end_audio = body.find_child("GoHomeDuckerAudio")
	
	end_text.visible = true
	Globals.touched_end = true
	end_audio.play()
	
	await get_tree().create_timer(2).timeout
	
	end_text.visible = false

func _ready() -> void:
	body_entered.connect(_on_body_entered)
