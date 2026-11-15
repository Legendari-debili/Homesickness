extends CharacterBody2D

const JUMP_VELOCITY := 30.0
const SPEED := 50.0
const LOST_ENERGY := 1

func kaput():
	pass
	
func _ready() -> void:
	var lives := []
	for my in get_children():
		if my.name.begins_with("Life"):
			lives.append(my)
	
	print(lives)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if is_on_floor():
		if Input.is_action_pressed("launch"):
			velocity.y = -(Globals.ep * JUMP_VELOCITY * 2)
			Globals.ep = clamp(Globals.ep - (LOST_ENERGY * 2), 0, INF)
		else:
			velocity.y = -(Globals.ep * JUMP_VELOCITY)
			Globals.ep = clamp(Globals.ep - LOST_ENERGY, 0, INF)

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * Globals.ep * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, Globals.ep * SPEED)
	
	move_and_slide()

func _process(delta: float):
	if position.y >= 100:
		kaput()
