extends Node

var i = 1
var color = "J"
var point_dep = 5
var last_move = ["", 0]
var nbr_doubles
onready var Game_node = get_parent().get_parent()

func set_nbr_doubles(var value):
	nbr_doubles = value

func set_last_move(var value, var pos):
	last_move[0] = value
	last_move[1] = pos

func get_nbr_doubles():
	return nbr_doubles

func get_last_move():
	return last_move

func kill(var victime, var pos):
	
	print(victime + " /KILLED")
	Game_node.get_node("Players").get_node(victime[0]).get_node(victime).set_in_base(true)
	BaseData.base_data["Base_" + victime[0]]["Pos" + victime[1]]["val"] = 1
	var x0 = BaseData.base_data["Base_" + victime[0]]["Pos" + victime[1]]["x"]
	var y0 = BaseData.base_data["Base_" + victime[0]]["Pos" + victime[1]]["y"]
	Game_node.get_node("Players").get_node(victime[0]).get_node(victime).position = Vector2(x0, y0)
	
	if (CaseData.case_data["Case" + str(pos)]["Item1"] == victime):
		CaseData.case_data["Case" + str(pos)]["Item1"] = "0"
	else:
		CaseData.case_data["Case" + str(pos)]["Item2"] = "0"
		var x = CaseData.case_data["Case" + str(pos)]["x"]
		var y = CaseData.case_data["Case" + str(pos)]["y"]
		get_node(CaseData.case_data["Case" + str(pos)]["Item1"]).position = Vector2(x, y)

func _ready():
	pass
