extends Node2D

const TILE_SIZE_PX := 48
const LEVEL_LENGTH_TILES := 10
const LEVEL_LENGTH_PX := TILE_SIZE_PX * LEVEL_LENGTH_TILES
var level_pos := Vector2(0, 0)

@onready var home_area = $HouseHouse/HomeArea
@onready var player = $Player

const LEVELS = [
	[preload("res://Scenes/Levels/level1.tscn"), preload("res://Scenes/Levels/level1e.tscn")],
	[preload("res://Scenes/Levels/level2.tscn"), preload("res://Scenes/Levels/level2e.tscn")],
	[preload("res://Scenes/Levels/level3.tscn"), preload("res://Scenes/Levels/level3e.tscn")],
	[preload("res://Scenes/Levels/level4.tscn"), preload("res://Scenes/Levels/level4e.tscn")],
	[preload("res://Scenes/Levels/level5.tscn"), preload("res://Scenes/Levels/level5e.tscn")],
	[preload("res://Scenes/Levels/level6.tscn")],
	[preload("res://Scenes/Levels/level7.tscn"), preload("res://Scenes/Levels/level7e.tscn")],
	[preload("res://Scenes/Levels/level8.tscn"), preload("res://Scenes/Levels/level8e.tscn")],
	[preload("res://Scenes/Levels/level9.tscn"), preload("res://Scenes/Levels/level9e.tscn")],
]

const END = preload("res://Scenes/Levels/end.tscn")

func create_level(level: Resource, pos: Vector2) -> void:
	var scene = level.instantiate()
	scene.global_position = pos
	add_child(scene)

func _ready() -> void:
	for i in range(1, Globals.level_count):
		var picked_level = LEVELS.pick_random().pick_random()
		level_pos = Vector2(LEVEL_LENGTH_PX * i, 0)
		create_level(picked_level, level_pos)
	
	var end_x_pos := Vector2(LEVEL_LENGTH_PX * Globals.level_count, 0)
	create_level(END, end_x_pos)
