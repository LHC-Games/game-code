extends Node

enum direction_enum {LEFT, RIGHT}

var checkpoint: Vector2
var needs_to_die: bool = false
var in_the_wind: bool = false
var wind_direction: direction_enum = direction_enum.LEFT
var player
var in_software: bool = false
