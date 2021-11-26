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
var players_list = ["J", "V", "R", "B"]
var go_value
var which_button
var safe_cases = [5, 12, 17, 22, 29, 34, 39, 46, 51, 56, 63, 68]


var x
var y
var rand1
var rand2

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
	which_button = 0
	print("tour suiv")
	get_node("Players").get_node(current_player).set_nbr_doubles(0)
	get_node("Players").get_node(current_player).set_last_move("", 0)
	activ_pickable()
	old += 1
	if (old > 3):
		old = 0
	current_player = players_list[old]
	desac_pickable()
	
	rnd()
	
	D1.disabled = false
	D2.disabled = false

func base_pleine() -> bool:
	for i in range(1, 5):
		if (BaseData.base_data["Base_" + current_player]["Pos" + str(i)]["val"] == 0):
			return false
	return true


func rnd():
	var tmp_nbr_doubles
	var tmp_last_move
#	rand1 = randi() % 6 + 1
#	rand2 = randi() % 6 + 1
	rand1 = 5
	rand2 = 5
	
	dice_texture(rand1, rand2)
	
	
	if (rand1 == rand2):
		tmp_nbr_doubles = get_node("Players").get_node(current_player).get_nbr_doubles()
		get_node("Players").get_node(current_player).set_nbr_doubles(tmp_nbr_doubles + 1)
		if (get_node("Players").get_node(current_player).get_nbr_doubles() == 3):
			tmp_last_move = get_node("Players").get_node(current_player).get_last_move()
			if tmp_last_move[0] != "":
				if (safezone[tmp_last_move[0][0]].has(tmp_last_move[1])):# protege
					tour_suiv()
				else:
					get_node("Players").get_node(current_player).kill(tmp_last_move[0], tmp_last_move[1])
					tour_suiv()
	

func relancer():
	rnd()

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

func _on_test_button_pressed():
	print("Base J : " + str(BaseData.base_data["Base_J"]["Pos1"]["val"]) + " " + str(BaseData.base_data["Base_J"]["Pos2"]["val"]) + " " + str(BaseData.base_data["Base_J"]["Pos3"]["val"]) + " " + str(BaseData.base_data["Base_J"]["Pos4"]["val"]))
	print("Base V : " + str(BaseData.base_data["Base_V"]["Pos1"]["val"]) + " " + str(BaseData.base_data["Base_V"]["Pos2"]["val"]) + " " + str(BaseData.base_data["Base_V"]["Pos3"]["val"]) + " " + str(BaseData.base_data["Base_V"]["Pos4"]["val"]))
	print("Base R : " + str(BaseData.base_data["Base_R"]["Pos1"]["val"]) + " " + str(BaseData.base_data["Base_R"]["Pos2"]["val"]) + " " + str(BaseData.base_data["Base_R"]["Pos3"]["val"]) + " " + str(BaseData.base_data["Base_R"]["Pos4"]["val"]))
	print("Base B : " + str(BaseData.base_data["Base_B"]["Pos1"]["val"]) + " " + str(BaseData.base_data["Base_B"]["Pos2"]["val"]) + " " + str(BaseData.base_data["Base_B"]["Pos3"]["val"]) + " " + str(BaseData.base_data["Base_B"]["Pos4"]["val"]))
	print("----------------")
	print("Item 1 : " + CaseData.case_data["Case22"]["Item1"])
	print("Item 2 : " + CaseData.case_data["Case22"]["Item2"])
	print(get_node("Players/B/B3").in_base)

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
		print("D1 pressed")


func _on_D2_pressed():
	if (go_value != 20):
		go_value = rand2
		which_button = 2
		print("D2 pressed")


func _on_hhh_pressed():
	print(go_value)
	go_value = 5

func _on_AcceptDialog_confirmed():
	get_tree().quit()
