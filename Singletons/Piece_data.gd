extends Node

var piece_data = {}

func _ready():
	var piece_data_file = File.new()
	piece_data_file.open("res://Infos/Piece_info.json",File.READ)
	var data = parse_json(piece_data_file.get_as_text())
	piece_data_file.close()
	piece_data = data
