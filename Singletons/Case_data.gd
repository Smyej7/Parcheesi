extends Node

var case_data = {}

func _ready():
	var case_data_file = File.new()
	case_data_file.open("res://Infos/Case_info.json",File.READ)
	var data = parse_json(case_data_file.get_as_text())
	case_data_file.close()
	case_data = data
