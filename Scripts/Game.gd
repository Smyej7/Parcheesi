extends Node

################################################
#################### SCENES #################### 
onready var Player = preload("res://Scenes/Player.tscn")


##################################################
#################### TEXTURES ####################
var J_texture = load("res://Assets/Jaune.png")
var V_texture = load("res://Assets/Vert.png")
var R_texture = load("res://Assets/Rouge.png")
var B_texture = load("res://Assets/Bleu.png")


###############################################
#################### NODES ####################
onready var Players = get_node("Players")



####################################################
#################### VARIABLESS ####################
var nouv_player


var x
var y

func _ready():
	instance_texture_players()
#	for p in Players.get_children():
#		for pp in p.get_children():
#			if (pp.name == "J4"):
#				pp.depart()
#				pp.avancer(6)
	
	


#func tour():
	

func instance_texture_players():
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


func _on_Button_pressed():
	print("button1 pressed")


func _on_Button2_pressed():
	print("button2 pressed")


func _on_test_button_pressed():
	print("Item1 : ", CaseData.case_data["Case65"]["Item1"])
	print("Item2 : ", CaseData.case_data["Case65"]["Item2"])
