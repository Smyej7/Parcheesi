extends Area2D

var vect_pos = Vector2.ZERO
var case_pos
onready var p_dep = get_parent().point_dep
onready var Game_node = get_parent().get_parent().get_parent()
onready var Parent_node = get_parent()

var x
var y

func _ready():
	pass

func depart():
	x = CaseData.case_data["Case" + str(p_dep)]["x"]
	y = CaseData.case_data["Case" + str(p_dep)]["y"]
	vect_pos = Vector2(x, y)
	
	position = vect_pos
	case_pos = p_dep

func avancer(nbr):
	
	if (Parent_node.is_in_group("J"))
	


func _on_Player_input_event(viewport, event, shape_idx):
	if Input.is_action_pressed("click_"):
		print(self.name)
