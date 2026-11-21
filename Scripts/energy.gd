extends Area2D

const GIVEN_ENERGY := 4

func _on_body_entered(body: Node) -> void:
	if body.name != "Player": return
	
	Globals.ep += GIVEN_ENERGY
	body.find_child("EPGainAudio").play()
	queue_free()
	
func _ready() -> void:
	body_entered.connect(_on_body_entered)
