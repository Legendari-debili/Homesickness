extends Node

var ep := 15
var pos_y := 0
var level_count := 3
var touched_end := false

func reset_global_variables(reset_level_count: bool = false) -> void:
	ep = 15
	pos_y = 0
	touched_end = false
	if reset_level_count: level_count = 3
