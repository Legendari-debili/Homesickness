extends CharacterBody2D

const JUMP_VELOCITY := 30.0
const SPEED := 50.0
const LOST_EP_PER_BOUNCE := 1
const LAUNCH_LOSS_COEFFICIENT := 2
const LOST_EP_PER_LAUNCH := LOST_EP_PER_BOUNCE * LAUNCH_LOSS_COEFFICIENT

@onready var bounce_audio = $BounceAudio
@onready var launch_audio = $LaunchAudio
@onready var lose_audio = $LoseAudio
@onready var stats_label = $StatsLabel

@onready var menu_button_paused = $MenuButtonPaused
@onready var menu_button_lost = $MenuButtonLost
@onready var resume_button = $ResumeButton
@onready var try_again_button = $TryAgainButton

@onready var pause_label = $PauseLabel
@onready var lose_label = $Lose


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if is_on_floor():
		if Input.is_action_pressed("launch"):
			velocity.y = -(Globals.ep * JUMP_VELOCITY * LAUNCH_LOSS_COEFFICIENT)
			Globals.ep = clamp(Globals.ep - LOST_EP_PER_LAUNCH, 0, INF)
			launch_audio.play()
		else:
			velocity.y = -(Globals.ep * JUMP_VELOCITY)
			Globals.ep = clamp(Globals.ep - LOST_EP_PER_BOUNCE, 0, INF)
			bounce_audio.play()

	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * Globals.ep * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, Globals.ep * SPEED)
	
	move_and_slide()

func _process(_delta: float) -> void:
	if position.y >= 100 or Globals.ep == 0:
		lose_label.visible = true
		lose_audio.play()
		if Globals.ep == 0: stats_label.text = "EP: 0\nLevels: " + str(Globals.level_count)
		get_tree().paused = true
	
		await get_tree().create_timer(5).timeout
		
		menu_button_lost.visible = true
		try_again_button.visible = true
	
	stats_label.text = "EP: " + str(Globals.ep) + "\nLevels: " + str(Globals.level_count)
	
	if Input.is_action_pressed("pause"):
		get_tree().paused = true
		menu_button_paused.visible = true
		resume_button.visible = true
		pause_label.visible = true

func _on_menu_pressed() -> void:
	Globals.reset_global_variables(true)
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/MainMenu/gui.tscn")

func _on_resume_pressed() -> void:
	get_tree().paused = false
	menu_button_paused.visible = false
	resume_button.visible = false
	pause_label.visible = false

func _on_try_again_pressed() -> void:
	Globals.reset_global_variables(true)
	Globals.in_game = true
	lose_label.visible = false
	get_tree().paused = false
	get_tree().call_deferred("reload_current_scene")
