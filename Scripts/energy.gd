extends Area2D

const GIVEN_ENERGY = 4

func _on_body_entered(body):
	Globals.ep += GIVEN_ENERGY
	print(Globals.ep)
	queue_free()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(_on_body_entered) # Replace with function body.
