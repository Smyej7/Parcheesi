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
#	case_pos = p_dep
	pass

func depart():
	var name0 = self.name
	
	if(from_to(p_dep-1, p_dep)):
		BaseData.base_data["Base_" + name0[0]]["Pos" + name0[1]]["val"] = 0
#		if (CaseData.case_data["Case" + str(p_dep)]["Item1"] == "0"):
#			CaseData.case_data["Case" + str(p_dep)]["Item1"] = self.name
#		else:
#			CaseData.case_data["Case" + str(p_dep)]["Item1"] = self.name
		case_pos = p_dep
		c_pos = case_pos
		go_to(case_pos)
		in_base = false

var temp_name1
var temp_name2

func go_to(pos_):
	var temp_name
	#supprimer la val depuis la case precedente
	if(CaseData.case_data["Case" + str(c_pos)]["Item1"] == self.name):
		CaseData.case_data["Case" + str(c_pos)]["Item1"] = "0"
		temp_name = CaseData.case_data["Case" + str(c_pos)]["Item2"]
		if (temp_name != "0"):
			CaseData.case_data["Case" + str(c_pos)]["Item1"] = CaseData.case_data["Case" + str(c_pos)]["Item2"]
			temp_name = CaseData.case_data["Case" + str(c_pos)]["Item1"]
			Game_node.get_node("Players").get_node(str(temp_name[0])).get_node(str(temp_name)).position = Vector2(CaseData.case_data["Case" + str(c_pos)]["x"], CaseData.case_data["Case" + str(c_pos)]["y"])
	else:
		CaseData.case_data["Case" + str(c_pos)]["Item2"] = "0"
		temp_name = CaseData.case_data["Case" + str(c_pos)]["Item1"]
		if (temp_name != "0"):# pas vrmnt besoin de ce test
			Game_node.get_node("Players").get_node(str(temp_name[0])).get_node(str(temp_name)).position = Vector2(CaseData.case_data["Case" + str(c_pos)]["x"], CaseData.case_data["Case" + str(c_pos)]["y"])
		
	if (pos_ == 108 || pos_ == 208 || pos_ == 308 || pos_ == 408):
		for i in range(1,5):
			if (CaseData.case_data["Case" + str(pos_)]["Item" + str(5-i)] == "0"):
				CaseData.case_data["Case" + str(pos_)]["Item" + str(5-i)] = self.name
				return
	else:
		x = CaseData.case_data["Case" + str(pos_)]["x"]
		y = CaseData.case_data["Case" + str(pos_)]["y"]
		vect_pos = Vector2(x, y)
		position = vect_pos
		
		if (CaseData.case_data["Case" + str(pos_)]["Item1"] == "0"):
			CaseData.case_data["Case" + str(pos_)]["Item1"] = self.name
			print("++++++++++++++++++++++++++++++++++++++++++++++++++++++")
		else:
			CaseData.case_data["Case" + str(pos_)]["Item2"] = self.name
			temp_name1 = CaseData.case_data["Case" + str(case_pos)]["Item1"]
			temp_name2 = CaseData.case_data["Case" + str(case_pos)]["Item2"]
			rect_pos(case_pos)
#			Game_node.get_node("Players").get_node(str(temp_name1[0])).get_node(str(temp_name1)).position = Vector2(CaseData.case_data["Case" + str(case_pos)]["x"]-11, CaseData.case_data["Case" + str(case_pos)]["y"])
#
#			Game_node.get_node("Players").get_node(str(temp_name2[0])).get_node(str(temp_name2)).position = Vector2(CaseData.case_data["Case" + str(case_pos)]["x"]+11, CaseData.case_data["Case" + str(case_pos)]["y"])
	print("land on Case ", pos_)
	print("Item1 : ", CaseData.case_data["Case" + str(pos_)]["Item1"])
	print("Item2 : ", CaseData.case_data["Case" + str(pos_)]["Item2"])

func rect_pos(var p):
	var vect = Vector2(CaseData.case_data["Case" + str(p)]["x"], CaseData.case_data["Case" + str(p)]["y"])
	if (p >= 60 && p <= 68) || (p >= 1 && p <= 8) || (p >= 26 && p <= 42) || (p >= 101 && p <= 107) || (p >= 301 && p <= 307):
		Game_node.get_node("Players").get_node(str(temp_name1[0])).get_node(str(temp_name1)).position = vect + Vector2(-11, 0)
		Game_node.get_node("Players").get_node(str(temp_name2[0])).get_node(str(temp_name2)).position = vect + Vector2(+11, 0)
		print("pos rectifiée pour ( " , temp_name1, " ) && ( " , temp_name2, " )")
	elif (p >= 9 && p <= 25) || (p >= 43 && p <= 59) || (p >= 201 && p <= 207) || (p >= 401 && p <= 407):
		Game_node.get_node("Players").get_node(str(temp_name1[0])).get_node(str(temp_name1)).position = vect + Vector2(0, +11)
		Game_node.get_node("Players").get_node(str(temp_name2[0])).get_node(str(temp_name2)).position = vect + Vector2(0, -11)
		print("pos rectifiée pour ( " , temp_name1, " ) && ( " , temp_name2, " )")
	else:
		print("-------------------------------------------------------")


func from_to(var from,to):
	var Item1
	var Item2
	for i in range(from+1, to+1):
		Item1 = CaseData.case_data["Case" + str(i)]["Item1"]
		Item2 = CaseData.case_data["Case" + str(i)]["Item2"]
		if ( Item1 != "0" &&  Item2 != "0"):
			print("from to false hh")
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

func kill(var target):
	BaseData.base_data["Base_" + BaseData.piece_info[str(int(target[1])-1)]]["Pos" + target[1]]["val"] = 1
	
#	CaseData.case_data["Case" + case_pos]["Item" + target[1]] = Parent_node.i

func _on_Player_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("click_"):
		if (in_base):
			depart()
		else:
			avancer(6)
	elif Input.is_action_just_pressed("test_click"):
		print("case_pos /// ", case_pos)
