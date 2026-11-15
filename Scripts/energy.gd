extends Area2D

const GIVEN_ENERGY := 4

func _on_body_entered(_body) -> void:
	Globals.ep += GIVEN_ENERGY
	queue_free()
	
func _ready() -> void:
	body_entered.connect(_on_body_entered)
