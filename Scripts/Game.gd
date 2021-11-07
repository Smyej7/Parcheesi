extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var J = $Players/Jaune/Player
onready var Player = preload("res://Scenes/Player.tscn")
var new_player
var v = Vector2.ZERO

var x
var y
func _ready():
	for e in CaseData.case_data:
		print(CaseData.case_data[e]['x'])
		x = CaseData.case_data[e]['x']
		y = CaseData.case_data[e]['y']
		v = Vector2(x,y)
		J.set_position(v)
		var t = Timer.new()
		t.set_wait_time(.5)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		yield(t, "timeout")
		t.queue_free()

var a = 23
func _on_Jaune2_input_event(viewport, event, shape_idx):
	if Input.is_action_pressed("click_"):
		J.position += (Vector2(a, 0))
		print(J.position.x)
		#a += 23.2




#	
#
