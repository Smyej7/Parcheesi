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
var current_player
var players_list = ["J", "V", "R", "B"]
var go_value
var which_button
var safe_cases = [5, 12, 17, 22, 29, 34, 39, 46, 51, 56, 63, 68]


var x
var y
var rand1
var rand2

################## GETTERS && SETTERS ##################
func set_go_value(var value):
	go_value = value

func get_go_value():
	return go_value
########################################################

func _ready():
	go_value = 0
	instance_texture_players()
	start()
	
	rand1 = randi() % 6 + 1
	rand2 = randi() % 6 + 1
	
	dice_texture(rand1, rand2)

func start():
	randomize()
	var rand_p = randi() % 4
	current_player = players_list[rand_p]
	
#	for p in Players.get_children():
#		if p.name != current_player:
#			for p0 in p.get_children():
#				p0.set_pickable(false)
	

#func tour_suiv():
	
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
	var t
	t = get_node("Players/J").get_children()
	for p in t:
		p.get_node("Sprite").set_texture(J_texture)
		p.set_nbr_doubles(0)
	t = get_node("Players/V").get_children()
	for p in t:
		p.get_node("Sprite").set_texture(V_texture)
		p.set_nbr_doubles(0)
	t = get_node("Players/R").get_children()
	for p in t:
		p.get_node("Sprite").set_texture(R_texture)
		p.set_nbr_doubles(0)
	t = get_node("Players/B").get_children()
	for p in t:
		p.get_node("Sprite").set_texture(B_texture)
		p.set_nbr_doubles(0)
	
#var a = 23
#func _on_Jaune2_input_event(viewport, event, shape_idx):
#	if Input.is_action_pressed("click_"):
#		J.position += (Vector2(a, 0))
#		print(J.position.x)
#		#a += 23.2

func _on_test_button_pressed():
	
	print("Item1 : ", CaseData.case_data["Case59"]["Item1"])
	print("Item2 : ", CaseData.case_data["Case59"]["Item2"])
	
	print(BaseData.base_data["Base_R"]["Pos1"]["val"])
	print(BaseData.base_data["Base_R"]["Pos2"]["val"])
	print(BaseData.base_data["Base_R"]["Pos3"]["val"])
	print(BaseData.base_data["Base_R"]["Pos4"]["val"])
	
#	print("#############")
#	print("Item1 : ", CaseData.case_data["Case108"]["Item1"])
#	print("Item2 : ", CaseData.case_data["Case108"]["Item2"])
#	print("Item3 : ", CaseData.case_data["Case108"]["Item3"])
#	print("Item4 : ", CaseData.case_data["Case108"]["Item4"])


func _on_D1_pressed():
	go_value = rand1
	which_button = 1
	print("D1 pressed")


func _on_D2_pressed():
	go_value = rand2
	which_button = 2
	print("D2 pressed")


func _on_hhh_pressed():
	print(go_value)
	go_value = 3
