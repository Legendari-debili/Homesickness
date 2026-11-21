extends Node

var ep := 75
var pos_y := 0
var level_count := 3
var in_game := false
var touched_end := false

func reset_global_variables(full_reset: bool = false) -> void:
	ep = 15
	pos_y = 0
	touched_end = false
	
	if full_reset:
		level_count = 3
		in_game = false
