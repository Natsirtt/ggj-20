extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var _scenario = {}
var _stage = {}
var stage_cntr = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	var file = File.new()
	file.open("res://scenarios/crash_001.json", file.READ)
	#_scenario.parse_json(file.get_as_text())
	#_set_next_stage()
	
func _set_next_stage():
	_stage = _scenario["stages"][stage_cntr]
	
func resolve_input(input_array : Array):
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
