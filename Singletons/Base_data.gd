extends Node

var base_data = {}

func _ready():
	var base_data_file = File.new()
	base_data_file.open("res://Infos/Base_info.json",File.READ)
	var data = parse_json(base_data_file.get_as_text())
	base_data_file.close()
	base_data = data
