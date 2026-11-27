extends Node

## GLOBAL VARIABLES ##
var ep: int = 15
var pos_y: int = 0
var level_count: int = 3

# Variables which can only be resetted using full_reset #
var in_game: bool = false
var touched_end: bool = false

func reset_global_variables(full_reset: bool = false) -> void:
	ep = 15
	pos_y = 0
	touched_end = false
	
	if full_reset:
		level_count = 3
		in_game = false
