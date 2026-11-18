extends CharacterBody2D

const JUMP_VELOCITY := 30.0
const SPEED := 50.0
const LOST_EP_PER_BOUNCE := 1
const LOST_EP_PER_LAUNCH := LOST_EP_PER_BOUNCE * 2

@onready var balls_plus_audio = $BallsPlus
@onready var launch_audio = $Launch
@onready var stats_label = $StatsLabel

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if is_on_floor():
		if Input.is_action_pressed("launch"):
			velocity.y = -(Globals.ep * JUMP_VELOCITY * 2)
			Globals.ep = clamp(Globals.ep - LOST_EP_PER_LAUNCH, 0, INF)
			launch_audio.play()
		else:
			velocity.y = -(Globals.ep * JUMP_VELOCITY)
			Globals.ep = clamp(Globals.ep - LOST_EP_PER_BOUNCE, 0, INF)
			balls_plus_audio.play()

	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * Globals.ep * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, Globals.ep * SPEED)
	
	move_and_slide()

func _process(_delta: float) -> void:
	if position.y >= 500 or Globals.ep == 0:
		var lose_text = find_child("Lose")
		var lose_sound = find_child("LoseAudio")
	
		lose_text.visible = true
		lose_sound.play()
		if Globals.ep == 0: stats_label.text = "EP: 0\nLevels: " + str(Globals.level_count)
		get_tree().paused = true
	
		await get_tree().create_timer(5).timeout
		
		lose_text.visible = false
		get_tree().paused = false
		get_tree().call_deferred("reload_current_scene")
		Globals.reset_global_variables()
		Globals.level_count = 3
		
	if Input.is_action_pressed("quit"): get_tree().quit()
	
	stats_label.text = "EP: " + str(Globals.ep) + "\nLevels: " + str(Globals.level_count)
