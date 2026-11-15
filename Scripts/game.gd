extends Node2D

const TILE_SIZE_PX = 48
const LEVEL_LENGTH_TILES = 10

const LEVELS = {
	1: [preload("res://Levels/level1.tscn"), preload("res://Levels/level1e.tscn")],
	2: [preload("res://Levels/level2.tscn"), preload("res://Levels/level2e.tscn")],
	3: [preload("res://Levels/level3.tscn"), preload("res://Levels/level3e.tscn")],
	4: [preload("res://Levels/level4.tscn"), preload("res://Levels/level4e.tscn")],
	5: [preload("res://Levels/level5.tscn"), preload("res://Levels/level5e.tscn")],
	6: [preload("res://Levels/level6.tscn")],
	7: [preload("res://Levels/level7.tscn"), preload("res://Levels/level7e.tscn")],
	8: [preload("res://Levels/level8.tscn"), preload("res://Levels/level8e.tscn")],
	9: [preload("res://Levels/level9.tscn"), preload("res://Levels/level9e.tscn")],
}

func create_level(level_nr):
	var scene_path = LEVELS.values().pick_random().pick_random()
	var picked_scene = scene_path.instantiate()
	var x_pos = TILE_SIZE_PX * LEVEL_LENGTH_TILES * level_nr
	picked_scene.global_position = Vector2(x_pos, 0)
	add_child(picked_scene)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(1, 5):
		create_level(i)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
