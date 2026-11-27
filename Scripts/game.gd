extends Node2D

var rng = RandomNumberGenerator.new()

const TILE_SIZE_PX: int = 48
const LEVEL_LENGTH_TILES: int = 10
const LEVEL_LENGTH_PX: int = TILE_SIZE_PX * LEVEL_LENGTH_TILES
var level_pos: Vector2 = Vector2(0, 0)

@onready var home_area: Area2D = $HouseHouse/HomeArea
@onready var player: CharacterBody2D = $Player

func load_levels() -> Array[Resource]:
	const PATH_TO_LEVELS: String = "res://Scenes/Levels"
	var loaded_levels: Array[Resource] = []
	
	for file_name: String in ResourceLoader.list_directory(PATH_TO_LEVELS):
		if !file_name.ends_with(".tscn"):
			push_warning("Found non-scene file", file_name, "in", PATH_TO_LEVELS)
			continue
		var scene_path: String = PATH_TO_LEVELS.path_join(file_name)
		loaded_levels.append(load(scene_path))
	
	return loaded_levels

var LEVELS = load_levels() # Treat this like a constant!
const END = preload("res://Scenes/end.tscn")

func create_level(scene: Resource, pos: Vector2) -> void:
	var level: TileMapLayer = scene.instantiate()
	level.global_position = pos
	var ep_spawns = level.get_children() as Array[Area2D]
	
	if rng.randi_range(0, 1) and !ep_spawns.is_empty():
		var ep = ep_spawns.pick_random()
		ep_spawns.erase(ep)
	
	for ep in ep_spawns: ep.queue_free()
	add_child(level)

func _ready() -> void:
	for i in range(1, Globals.level_count):
		var picked_level = LEVELS.pick_random()
		level_pos = Vector2(LEVEL_LENGTH_PX * i, 0)
		create_level(picked_level, level_pos)
	
	var end_pos: Vector2 = Vector2(LEVEL_LENGTH_PX * Globals.level_count, 0)
	var end_level: TileMapLayer = END.instantiate()
	end_level.global_position = end_pos
	add_child(end_level)
