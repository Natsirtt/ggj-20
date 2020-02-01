extends Node

var _scenario = {}
var _stage = {}
var stage_cntr = 0

# SIGNALS
signal stage_changed
signal crash
signal won

func _ready():
	var file = File.new()
	file.open("res://scenarios/crash_001.json", file.READ)
	# TODO should probably check if result is valid, if I had the time
	_scenario = JSON.parse(file.get_as_text()).result
	_set_next_stage()
	
func _set_next_stage():
	if stage_cntr < _scenario["stages"].size():
		_stage = _scenario["stages"][stage_cntr]
		print(get_prompt())
	else:
		print("won")
		emit_signal("won")
	stage_cntr += 1
	
func resolve_input(input_array : Array):
	# for now just cycle through the stages
	if true:
		_set_next_stage()
	emit_signal("stage_changed")

func get_prompt():
	return _stage["prompt"]

func get_instruction():
	return _stage["instruction"]
	
func get_result_message():
	# select the correct success / failure message depending on input failures
	return _stage["success"]

func _input(event):
	if event.is_action_pressed("execute"):
		_set_next_stage()