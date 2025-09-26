extends Node2D

var get_path_from_previous_scene = ""
var get_data = {}
var data 
var situation

func change_scene_with_data(path: String, data: Dictionary = {}):
	get_path_from_previous_scene = path
	get_data = data
	get_tree().change_scene_to_file(path)

func clear_data_previous():
	get_path_from_previous_scene = ""
	get_data = {}
	
func start_quiz(value):
	Global.stop_with_fade()
	situation = value
	data = load("res://source/situation" + str(value) +".json")
	get_tree().change_scene_to_file("res://scene/quiz.tscn")
	
