extends Node

var i = 1
var color = "J"
var point_dep = 5
var last_move = ["", 0]
var nbr_doubles
var MAX = 108

func set_nbr_doubles(var value):
	nbr_doubles = value

func set_last_move(var value, var pos):
	last_move[0] = value
	last_move[1] = pos

func get_nbr_doubles():
	return nbr_doubles

func get_last_move():
	return last_move

func _ready():
	pass
