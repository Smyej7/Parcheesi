extends Node

################################################
#################### SCENES #################### 
onready var Player = preload("res://Scenes/Player.tscn")
onready var D1 = $Dices/D1
onready var D2 = $Dices/D2


##################################################
#################### TEXTURES ####################
var J_texture = load("res://Assets/Jaune.png")
var V_texture = load("res://Assets/Vert.png")
var R_texture = load("res://Assets/Rouge.png")
var B_texture = load("res://Assets/Bleu.png")

var D1_texture = load("res://Assets/dieWhite_border1.png")
var D2_texture = load("res://Assets/dieWhite_border2.png")
var D3_texture = load("res://Assets/dieWhite_border3.png")
var D4_texture = load("res://Assets/dieWhite_border4.png")
var D5_texture = load("res://Assets/dieWhite_border5.png")
var D6_texture = load("res://Assets/dieWhite_border6.png")


###############################################
#################### NODES ####################
onready var Players = get_node("Players")



####################################################
#################### VARIABLESS ####################
#var nouv_player
var safezone = { "J" : [101, 102, 103, 104, 105, 106, 107, 108],
				 "V" : [201, 202, 203, 204, 205, 206, 207, 208],
				 "R" : [301, 302, 303, 304, 305, 306, 307, 308],
				 "B" : [401, 402, 403, 404, 405, 406, 407, 408]}

var current_player
var players_list = ["J", "B", "R", "V"]
var go_value
var which_button
var safe_cases = [5, 12, 17, 22, 29, 34, 39, 46, 51, 56, 63, 68]


var x
var y
var rand1 = -1
var rand2 = -1

var game_over
var old

################## GETTERS && SETTERS ##################
func set_go_value(var value):
	go_value = value

func get_go_value():
	return go_value
########################################################

func _ready():
	randomize()
	go_value = 0
	game_over = false
	instance_texture_players()
	start()


#func _ready():
#	var tmp_last_move = ["jk", 12]
#	print(tmp_last_move[0][0])
##	print(safezone[tmp_last_move[0][0]].has(tmp_last_move[1]))

func desac_pickable():
	for p in Players.get_children():
		if p.name != current_player:
			for p0 in p.get_children():
				p0.set_pickable(false)

func activ_pickable():
	for p in Players.get_children():
		for p0 in p.get_children():
			p0.set_pickable(true)

func start():
	var rand_p = randi() % 4
	old = rand_p
	current_player = players_list[old]
	desac_pickable()
	tour_suiv()

func tour_suiv():
	
	D1.disabled = false
	D2.disabled = false
	
	which_button = 0
	print(current_player + " |" + str(rand1) + "| |" + str(rand2) + "|" + " bloqué -> " + str(jr_bloque(rand1, rand2)))
	print("----------------------------------- tour suiv -----------------------------------")
	get_node("Players").get_node(current_player).set_nbr_doubles(0)
	get_node("Players").get_node(current_player).set_last_move("", 0)
	activ_pickable()
	old += 1
	if (old > 3):
		old = 0
	current_player = players_list[old]
	desac_pickable()
	
	
	rnd()
	
#	if (D1_is_disabled() && D2_is_disabled()):
#		print("che3loo")
#		D1.disabled = false
#		D2.disabled = false

func base_pleine() -> bool:
	for i in range(1, 5):
		if (BaseData.base_data["Base_" + current_player]["Pos" + str(i)]["val"] == 0):
			return false
	return true

func base_vide() -> bool:
	for i in range(1, 5):
		if (BaseData.base_data["Base_" + current_player]["Pos" + str(i)]["val"] == 1):
			return false
	return true
	
func premier_base_elem():
	for i in range(1, 5):
		if (BaseData.base_data["Base_" + current_player]["Pos" + str(i)]["val"] == 1):
			return i

func from_to(var from,to):
	print("from : " + str(from) + " to : " + str(to))
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

func jr_bloque(var rnd1, var rnd2) -> bool:
	
	var tmp_case_pos
	var tmp_p_dep
	
	
	for i in range(1, 5):
		tmp_case_pos = get_node("Players").get_node(current_player).get_node(current_player + str(i)).get_case_pos()
		
		if(!get_node("Players").get_node(current_player).get_node(current_player + str(i)).in_base): # check pr tt les jrs not in base
			if (!D1.disabled):
				if (tmp_case_pos <= 68 && tmp_case_pos + rnd1 > 68):
					if (from_to(tmp_case_pos, 68) && from_to(0, (tmp_case_pos+rnd1)-68)):
						return false
				elif (!get_node("Players").get_node(current_player).get_node(current_player + str(i)).in_tapis_rouge()):
					if (from_to(tmp_case_pos, tmp_case_pos + rnd1)):
						return false
				else: # kayn f tapis rouge
					if (!(tmp_case_pos + rnd1 > get_node("Players").get_node(current_player).MAX)):
						if (from_to(tmp_case_pos, tmp_case_pos + rnd1)):
							return false
			if (!D2.disabled):
				if (tmp_case_pos <= 68 && tmp_case_pos + rnd2 > 68):
					if (from_to(tmp_case_pos, 68) && from_to(0, (tmp_case_pos+rnd2)-68)):
						return false
				elif (!get_node("Players").get_node(current_player).get_node(current_player + str(i)).in_tapis_rouge()):
					if (from_to(tmp_case_pos, tmp_case_pos + rnd2)):
						return false
				else: # kayn f tapis rouge
					if (!(tmp_case_pos + rnd2 > get_node("Players").get_node(current_player).MAX)):
						if (from_to(tmp_case_pos, tmp_case_pos + rnd2)):
							return false
			if (go_value == 20):
				if (can_ply_20()):
					return false
				return true
		else:																						# check pr tt les jrs in base
			if ((rnd1 + rnd2) == 5):
				tmp_p_dep = get_node("Players").get_node(current_player).point_dep
				if (get_node("Players").get_node(current_player).get_node(current_player + str(i)).depart()):
					return false
	if (go_value == 20):
		print("joueur bloque go_value -> 0")
		set_go_value(0)
	return true


func can_ply_20() -> bool:
	var tmp_case_pos
	
	for i in range(1, 5):
		tmp_case_pos = get_node("Players").get_node(current_player).get_node(current_player + str(i)).get_case_pos()
		if(!get_node("Players").get_node(current_player).get_node(current_player + str(i)).in_base && !get_node("Players").get_node(current_player).get_node(current_player + str(i)).in_tapis_rouge()):
			if (tmp_case_pos <= 68 && tmp_case_pos + 20 > 68):
				if (from_to(tmp_case_pos, 68) && from_to(0, (tmp_case_pos + 20)-68)):
					return true
			else:
				if (from_to(tmp_case_pos, tmp_case_pos + 20)):
					return true
	return false

#var b = true
func rnd():
	var tmp_nbr_doubles
	var tmp_last_move
	var dep = get_node("Players").get_node(current_player).point_dep
	
#	if (b):
#		rand1 = 5
#		rand2 = 5
#	else:
#		rand1 = randi() % 6 + 1
#		rand2 = randi() % 6 + 1
#	b = false
	
	rand1 = randi() % 6 + 1
	rand2 = randi() % 6 + 1
	
	print("rand1 : " + str(rand1))
	print("rand2 : " + str(rand2))
	
	dice_texture(rand1, rand2)
	
#	print("can_ply_20() : " + str(can_ply_20()))
	
	if (rand1 == rand2):
		tmp_nbr_doubles = get_node("Players").get_node(current_player).get_nbr_doubles()
		get_node("Players").get_node(current_player).set_nbr_doubles(tmp_nbr_doubles + 1)
		if (get_node("Players").get_node(current_player).get_nbr_doubles() == 3):
			tmp_last_move = get_node("Players").get_node(current_player).get_last_move()
			if tmp_last_move[0] != "":
				if (safezone[tmp_last_move[0][0]].has(tmp_last_move[1])):# protege
					tour_suiv()
				else:
					kill(tmp_last_move[0], tmp_last_move[1])
					tour_suiv()
		else:
			if (base_pleine() && rand1 != 5):
#				tour_suiv()
				relancer()
			elif (rand1 == 5):# rand1 == rand2
				if (CaseData.case_data["Case" + str(dep)]["Item1"] == "0"):
					if (!base_vide()):
						get_node("Players").get_node(current_player).get_node(current_player + str(premier_base_elem())).depart()
						D1.disabled = true
						print("D1 disabled // hadi dyal 5 5")
					if (!base_vide()):
						get_node("Players").get_node(current_player).get_node(current_player + str(premier_base_elem())).depart()
						D2.disabled = true
						print("D2 disabled // hadi dyal 5 5")
						relancer()
				elif (CaseData.case_data["Case" + str(dep)]["Item2"] == "0"):
					if (!base_vide()):
						get_node("Players").get_node(current_player).get_node(current_player + str(premier_base_elem())).depart()
						D1.disabled = true
						print("D1 disabled // hadi dyal 5 5")
	elif ((rand1 + rand2) == 5):
		if (!base_vide()):
			
			if (CaseData.case_data["Case" + str(dep)]["Item1"][0] != "0" && CaseData.case_data["Case" + str(dep)]["Item2"][0] != "0"): # les 2 nn vides
				if (!(CaseData.case_data["Case" + str(dep)]["Item1"][0] == current_player && CaseData.case_data["Case" + str(dep)]["Item2"][0] == current_player)): # 1 ennemi minimum
					D1.disabled = true
					D2.disabled = true
					if (CaseData.case_data["Case" + str(dep)]["Item2"][0] != current_player):
						kill(CaseData.case_data["Case" + str(dep)]["Item2"], dep)
						set_go_value(20)
						get_node("Players").get_node(current_player).get_node(current_player + str(premier_base_elem())).depart()
#						CaseData.case_data["Case" + str(dep)]["Item2"] = current_player + str(premier_base_elem())
#						var x0 = CaseData.case_data["Case" + str(dep)]["x"]
#						var y0 = CaseData.case_data["Case" + str(dep)]["y"]
#						get_node("Players").get_node(current_player + str(premier_base_elem())).position = Vector2(x0, y0)
					else:
						kill(CaseData.case_data["Case" + str(dep)]["Item1"], dep)
						set_go_value(20)
						get_node("Players").get_node(current_player).get_node(current_player + str(premier_base_elem())).depart()
#						CaseData.case_data["Case" + str(dep)]["Item1"] = current_player + str(premier_base_elem())
#						var x0 = CaseData.case_data["Case" + str(dep)]["x"]
#						var y0 = CaseData.case_data["Case" + str(dep)]["y"]
#						get_node("Players").get_node(current_player + str(premier_base_elem())).position = Vector2(x0, y0)
			elif (CaseData.case_data["Case" + str(dep)]["Item1"][0] == "0" || CaseData.case_data["Case" + str(dep)]["Item2"][0] == "0"): # soit 1 vide (la 2eme), soit les 2 vides
				
				get_node("Players").get_node(current_player).get_node(current_player + str(premier_base_elem())).depart()
				tour_suiv()
			else:
				print("here!")
	elif (!base_vide() && (rand1 == 5 || rand2 == 5)):
		if (get_node("Players").get_node(current_player).get_node(current_player + str(premier_base_elem())).depart()):
			if (rand1 == 5):
				print("d1 desactivee")
				D1.disabled = true
			else:
				print("d2 desactivee")
				D2.disabled = true
	elif (base_pleine() && rand1 != 5 && rand2 != 5):
		tour_suiv()

func relancer():
	print("relancer")
	D1.disabled = false
	D2.disabled = false
	rnd()

func kill(var victime, var pos):
	
	print(victime + " /KILLED")
	get_node("Players").get_node(victime[0]).get_node(victime).set_in_base(true)
	BaseData.base_data["Base_" + victime[0]]["Pos" + victime[1]]["val"] = 1
	var x0 = BaseData.base_data["Base_" + victime[0]]["Pos" + victime[1]]["x"]
	var y0 = BaseData.base_data["Base_" + victime[0]]["Pos" + victime[1]]["y"]
	get_node("Players").get_node(victime[0]).get_node(victime).position = Vector2(x0, y0)
	
	if (CaseData.case_data["Case" + str(pos)]["Item1"] == victime):
		CaseData.case_data["Case" + str(pos)]["Item1"] = "0"
	else:
		CaseData.case_data["Case" + str(pos)]["Item2"] = "0"
		var x = CaseData.case_data["Case" + str(pos)]["x"]
		var y = CaseData.case_data["Case" + str(pos)]["y"]
		get_node("Players").get_node(CaseData.case_data["Case" + str(pos)]["Item1"][0]).get_node(CaseData.case_data["Case" + str(pos)]["Item1"]).position = Vector2(x, y)

func dice_texture(var t1, var t2):
	x = DiceData.diece_data["Dice_" + current_player]["x1"]
	y = DiceData.diece_data["Dice_" + current_player]["y1"]
	$Dices/D1.set_position(Vector2(x, y))
	
	x = DiceData.diece_data["Dice_" + current_player]["x2"]
	y = DiceData.diece_data["Dice_" + current_player]["y2"]
	$Dices/D2.set_position(Vector2(x, y))
	
	D1.icon = load("res://Assets/dieWhite_border" + str(t1) + ".png")
	D2.icon = load("res://Assets/dieWhite_border" + str(t2) + ".png")

func instance_texture_players():
	
	get_node("Players/J").set_nbr_doubles(0)
	get_node("Players/V").set_nbr_doubles(0)
	get_node("Players/R").set_nbr_doubles(0)
	get_node("Players/B").set_nbr_doubles(0)
	
	var t
	t = get_node("Players/J").get_children()
	for p in t:
		p.get_node("Sprite").set_texture(J_texture)
	t = get_node("Players/V").get_children()
	for p in t:
		p.get_node("Sprite").set_texture(V_texture)
	t = get_node("Players/R").get_children()
	for p in t:
		p.get_node("Sprite").set_texture(R_texture)
	t = get_node("Players/B").get_children()
	for p in t:
		p.get_node("Sprite").set_texture(B_texture)
	
#var a = 23
#func _on_Jaune2_input_event(viewport, event, shape_idx):
#	if Input.is_action_pressed("click_"):
#		J.position += (Vector2(a, 0))
#		print(J.position.x)
#		#a += 23.2


func D1_is_disabled() -> bool:
	if (D1.disabled):
		return true
	else:
		return false

func D2_is_disabled() -> bool:
	if (D2.disabled):
		return true
	else:
		return false

func _on_D1_pressed():
	if (go_value != 20):
		go_value = rand1
		which_button = 1


func _on_D2_pressed():
	if (go_value != 20):
		go_value = rand2
		which_button = 2

func _on_AcceptDialog_confirmed():
	get_tree().quit()
