extends Node

var diece_data = {}

func _ready():
	var diece_data_file = File.new()
	diece_data_file.open("res://Infos/Dice_info.json",File.READ)
	var data = parse_json(diece_data_file.get_as_text())
	diece_data_file.close()
	diece_data = data
