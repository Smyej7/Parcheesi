extends Area2D

var vect_pos = Vector2.ZERO
var case_pos
var c_pos
onready var p_dep = get_parent().point_dep
onready var Game_node = get_parent().get_parent().get_parent()
onready var Parent_node = get_parent()

var x
var y

var in_base = true

func _ready():
	pass

func depart():
	case_pos = p_dep
	go_to(case_pos)
	in_base = false

func go_to(pos_):
	if (pos_ == 108 || pos_ == 208 || pos_ == 308 || pos_ == 408):
		#supprimer la val depuis la case precedente
		if(CaseData.case_data["Case" + str(c_pos)]["Item1"] == self.name):
			CaseData.case_data["Case" + str(c_pos)]["Item1"] = "0"
		else:
			CaseData.case_data["Case" + str(c_pos)]["Item2"] = "0"
		for i in range(1,5):
			if (CaseData.case_data["Case" + str(pos_)]["Item" + str(5-i)] == "0"):
				CaseData.case_data["Case" + str(pos_)]["Item" + str(5-i)] = self.name
				return
	else:
		x = CaseData.case_data["Case" + str(pos_)]["x"]
		y = CaseData.case_data["Case" + str(pos_)]["y"]
		vect_pos = Vector2(x, y)
		position = vect_pos
	print("land on Case ", pos_)

func from_to(var from,to):
	var mouve_valide = false
	var Item1
	var Item2
	for i in range(from+1, to+1):
		Item1 = CaseData.case_data["Case" + str(i)]["Item1"]
		Item2 = CaseData.case_data["Case" + str(i)]["Item2"]
		if ( Item1 != "0" &&  Item2 != "0"):
			return false
	
	return true

func avancer(nbr):
	var next_pos = case_pos + nbr
	c_pos = case_pos
	
	if (Parent_node.is_in_group("J")):
		if (case_pos > 100 && next_pos > 108):
			print("select another dice")
		elif (next_pos > 68 && case_pos <= 68):
			case_pos = 100 + next_pos - 68
			if (from_to(case_pos, next_pos)):
				go_to(case_pos)
		else:
			if (from_to(case_pos, next_pos)):
				case_pos = next_pos
				go_to(case_pos)
		
	if (Parent_node.is_in_group("V")):
		if (next_pos > 68 && next_pos < 100):
			next_pos -= 68
		if (case_pos > 200 && next_pos > 208):
			print("select another dice")
		elif (next_pos > 51 && case_pos <= 51):
			case_pos = 200 + next_pos - 51
			if (from_to(case_pos, next_pos)):
				go_to(case_pos)
		else:
			if (from_to(case_pos, next_pos)):
				case_pos = next_pos
				go_to(case_pos)
		
	if (Parent_node.is_in_group("R")):
		if (next_pos > 68 && next_pos < 100):
			next_pos -= 68
		if (case_pos > 300 && next_pos > 308):
			print("select another dice")
		elif (next_pos > 34 && case_pos <= 34):
			case_pos = 300 + next_pos - 34
			if (from_to(case_pos, next_pos)):
				go_to(case_pos)
		else:
			if (from_to(case_pos, next_pos)):
				case_pos = next_pos
				go_to(case_pos)
		
	if (Parent_node.is_in_group("B")):
		if (next_pos > 68 && next_pos < 100):
			next_pos -= 68
		if (case_pos > 400 && next_pos > 408):
			print("select another dice")
		elif (next_pos > 17 && case_pos <= 17):
			case_pos = 400 + next_pos - 17
			if (from_to(case_pos, next_pos)):
				go_to(case_pos)
		else:
			if (from_to(case_pos, next_pos)):
				case_pos = next_pos
				go_to(case_pos)


func _on_Player_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("click_"):
		if (in_base):
			depart()
		else:
			avancer(6)
