extends Area2D

var vect_pos = Vector2.ZERO
var case_pos
var c_pos
onready var p_dep = get_parent().point_dep
onready var Game_node = get_parent().get_parent().get_parent()
onready var Parent_node = get_parent()

var nbr_doubles


var x
var y

var in_base = true

################## GETTERS && SETTERS ##################
func set_nbr_doubles(var value):
	nbr_doubles = value

func get_nbr_doubles():
	return nbr_doubles

func set_in_base(var value):
	in_base = value
########################################################

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
		return true
	else:
		return false

var temp_name1
var temp_name2

func go_to(pos_):
	print("pos_ : ", pos_)
	case_pos = pos_
	var temp_name
	#supprimer la val depuis la case precedente
	if(CaseData.case_data["Case" + str(c_pos)]["Item1"] == self.name):
		CaseData.case_data["Case" + str(c_pos)]["Item1"] = "0"
		temp_name = CaseData.case_data["Case" + str(c_pos)]["Item2"]
		if (temp_name != "0"):
			CaseData.case_data["Case" + str(c_pos)]["Item1"] = CaseData.case_data["Case" + str(c_pos)]["Item2"]
			CaseData.case_data["Case" + str(c_pos)]["Item2"] = "0"
			temp_name = CaseData.case_data["Case" + str(c_pos)]["Item1"]
			Game_node.get_node("Players").get_node(str(temp_name[0])).get_node(str(temp_name)).position = Vector2(CaseData.case_data["Case" + str(c_pos)]["x"], CaseData.case_data["Case" + str(c_pos)]["y"])
	else:
		CaseData.case_data["Case" + str(c_pos)]["Item2"] = "0"
		temp_name = CaseData.case_data["Case" + str(c_pos)]["Item1"]
		if (temp_name != "0"):# pas vrmnt besoin de ce test
			Game_node.get_node("Players").get_node(str(temp_name[0])).get_node(str(temp_name)).position = Vector2(CaseData.case_data["Case" + str(c_pos)]["x"], CaseData.case_data["Case" + str(c_pos)]["y"])
		
	if (pos_ == 108 || pos_ == 208 || pos_ == 308 || pos_ == 408):
		
		if (CaseData.case_data["Case" + str(c_pos)]["Item1"] == self.name):
			CaseData.case_data["Case" + str(c_pos)]["Item1"] = "0"
		else:
			CaseData.case_data["Case" + str(c_pos)]["Item2"] = "0"
			
		for i in range(1,5):
			if (CaseData.case_data["Case" + str(pos_)]["Item" + str(5-i)] == "0"):
				CaseData.case_data["Case" + str(pos_)]["Item" + str(5-i)] = self.name
				Game_node.get_node("Players").get_node(self.name[0]).get_node(self.name).position = Vector2(CaseData.case_data["Case" + str(pos_)]["x" + str(5-i)], CaseData.case_data["Case" + str(pos_)]["y" + str(5-i)])
				return
	else:
		x = CaseData.case_data["Case" + str(pos_)]["x"]
		y = CaseData.case_data["Case" + str(pos_)]["y"]
		vect_pos = Vector2(x, y)
		position = vect_pos
		
		if (CaseData.case_data["Case" + str(pos_)]["Item1"] == "0"):
			CaseData.case_data["Case" + str(pos_)]["Item1"] = self.name
		else:
			if (Game_node.safe_cases.has(pos_)):
				
				CaseData.case_data["Case" + str(pos_)]["Item2"] = self.name
				temp_name1 = CaseData.case_data["Case" + str(case_pos)]["Item1"]
				temp_name2 = CaseData.case_data["Case" + str(case_pos)]["Item2"]
				rect_pos(case_pos)
			else:
				var victime = CaseData.case_data["Case" + str(pos_)]["Item1"]
				kill(victime)
				CaseData.case_data["Case" + str(pos_)]["Item1"] = self.name
				Game_node.set_go_value(20)
				print(Game_node.get_go_value())
	
	print("land on Case ", pos_)
	print("Item1 : ", CaseData.case_data["Case" + str(pos_)]["Item1"])
	print("Item2 : ", CaseData.case_data["Case" + str(pos_)]["Item2"])

func kill(var victime):
	print("KILLED")
	Game_node.get_node("Players").get_node(victime[0]).get_node(victime).set_in_base(true)
	BaseData.base_data["Base_" + victime[0]]["Pos" + victime[1]]["val"] = 1
	var x0 = BaseData.base_data["Base_" + victime[0]]["Pos" + victime[1]]["x"]
	var y0 = BaseData.base_data["Base_" + victime[0]]["Pos" + victime[1]]["y"]
	Game_node.get_node("Players").get_node(victime[0]).get_node(victime).position = Vector2(x0, y0)

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
			print("a cause de la case ", i)
			print("from to false hh")
			return false
	
	return true

func avancer(nbr):
	var next_pos = case_pos + nbr
	c_pos = case_pos
	
	if (Parent_node.is_in_group("J")):
		if (case_pos < 68 && next_pos <= 68):# mn bra l bra
			if (from_to(case_pos, next_pos)):
				go_to(next_pos)
				return true
			else:
				return false
		elif (case_pos <= 68 && next_pos > 68):# mn bra l dakhel
			next_pos = 100 + next_pos - 68
			if (from_to(case_pos, 68)):# lpiste li bra wach clean
				if (from_to(100, next_pos)):# lpiste li ldakhel wach clean
					go_to(next_pos)
					return true
				else:
					return false
			else:
				return false
		elif (case_pos >= 101 && next_pos <= 108):# mn ldakhel l ldakhel
			if (from_to(case_pos, next_pos)):# lpiste li ldakhel wach clean
				go_to(next_pos)
				return true
			else:
				return false
		elif (case_pos >= 101 && next_pos > 108):# overflow
			print("selectionnez une autre piece")
			return false
	
	if (Parent_node.is_in_group("V")):
		if (case_pos >= 56 && next_pos <= 68 || case_pos >= 1 && next_pos <= 51):# mn bra l bra
			if (from_to(case_pos, next_pos)):
				go_to(next_pos)
				return true
			else:
				return false
		elif (case_pos >= 56 && case_pos <= 68) && (next_pos > 68):# mn bra l bra // mn secteur dyalo lbra
			next_pos -= 68
			if (from_to(case_pos, 68)):
				if (from_to(0, next_pos)):
					go_to(next_pos)
					return true
				else:
					return false
			else:
				return false
		elif(case_pos <= 51 && next_pos > 51):# mn bra ldakhel
			next_pos = 200 + next_pos - 51
			if (from_to(case_pos, 51)):# lpiste li bra wach clean
				if (from_to(200, next_pos)):# lpiste li ldakhel wach clean
					go_to(next_pos)
					return true
				else:
					return false
			else:
				return false
		elif (case_pos >= 201 && next_pos <= 208):# mn ldakhel l ldakhel
			if (from_to(case_pos, next_pos)):# lpiste li ldakhel wach clean
				go_to(next_pos)
				return true
			else:
				return false
		elif (case_pos >= 201 && next_pos > 208):# overflow
			print("selectionnez une autre piece")
			return false
	
	if (Parent_node.is_in_group("R")):
		if (case_pos >= 39 && next_pos <= 68 || case_pos >= 1 && next_pos <= 34):# mn bra l bra
			if (from_to(case_pos, next_pos)):
				go_to(next_pos)
				return true
			else:
				return false
		elif (case_pos >= 39 && case_pos <= 68) && (next_pos > 68):# mn bra l bra // mn secteur dyalo lbra
			next_pos -= 68
			if (from_to(case_pos, 68)):
				if (from_to(0, next_pos)):
					go_to(next_pos)
					return true
				else:
					return false
			else:
				return false
		elif(case_pos <= 34 && next_pos > 34):# mn bra ldakhel
			next_pos = 300 + next_pos - 34
			if (from_to(case_pos, 34)):# lpiste li bra wach clean
				if (from_to(300, next_pos)):# lpiste li ldakhel wach clean
					go_to(next_pos)
					return true
				else:
					return false
			else:
				return false
		elif (case_pos >= 301 && next_pos <= 308):# mn ldakhel l ldakhel
			if (from_to(case_pos, next_pos)):# lpiste li ldakhel wach clean
				go_to(next_pos)
				return true
			else:
				return false
		elif (case_pos >= 301 && next_pos > 308):# overflow
			print("selectionnez une autre piece")
			return false
	
	if (Parent_node.is_in_group("B")):
		if (case_pos >= 22 && next_pos <= 68 || case_pos >= 1 && next_pos <= 17):# mn bra l bra
			if (from_to(case_pos, next_pos)):
				go_to(next_pos)
				return true
			else:
				return false
		elif (case_pos >= 22 && case_pos <= 68) && (next_pos > 68):# mn bra l bra // mn secteur dyalo lbra
			next_pos -= 68
			if (from_to(case_pos, 68)):
				if (from_to(0, next_pos)):
					go_to(next_pos)
					return true
				else:
					return false
			else:
				return false
		elif(case_pos <= 17 && next_pos > 17):# mn bra ldakhel
			next_pos = 400 + next_pos - 17
			if (from_to(case_pos, 17)):# lpiste li bra wach clean
				if (from_to(400, next_pos)):# lpiste li ldakhel wach clean
					go_to(next_pos)
					return true
				else:
					return false
			else:
				return false
		elif (case_pos >= 401 && next_pos <= 408):# mn ldakhel l ldakhel
			if (from_to(case_pos, next_pos)):# lpiste li ldakhel wach clean
				go_to(next_pos)
				return true
			else:
				return false
		elif (case_pos >= 401 && next_pos > 408):# overflow
			print("selectionnez une autre piece")
			return false

func desac_button():
	if(Game_node.which_button == 1):
		Game_node.get_node("Dices/D1").set_disabled(true)
	elif(Game_node.which_button == 2):
		Game_node.get_node("Dices/D2").set_disabled(true)

func _on_Player_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("click_"):
		if (in_base):
			if (Game_node.go_value == 5):
				var testd = depart()
				if (testd):
					Game_node.go_value = 0
					desac_button()
		elif(Game_node.go_value != 0):
			var test = avancer(Game_node.go_value)
			print("go_value // ", Game_node.go_value)
			if (test):
				Game_node.go_value = 0
				desac_button()
			print("test // ", test)
