extends Node

var _scenario = {}
var _stage = {}
var _failure_idx = 0
var stage_cntr = 0

# SIGNALS
signal new_instructions
signal new_prompt
signal crash
signal won

func _ready():
	var file = File.new()
	file.open("res://scenarios/crash_001.json", file.READ)
	# TODO should probably check if result is valid, if I had the time
	_scenario = JSON.parse(file.get_as_text()).result
	get_node("../ControlPanel").connect("pressed_execute", self, "resolve_input")
	get_node("../Camera").shake_strength = 0
	
	_set_next_stage()
	
func _set_next_stage():
	if stage_cntr < _scenario["stages"].size():
		_stage = _scenario["stages"][stage_cntr]
		print(_stage["prompt"])
		update_prompt()
		update_instructions()
	else:
		print("won")
		emit_signal("won")
	stage_cntr += 1
	
	
func resolve_input(input_array : Array):
	var expected_list = _stage["inputs"]
	
	var expected = {}
	var input = null
	var failures = 0
	for idx in range(expected_list.size()):
		expected =  expected_list[idx]
		for input_btn in input_array:
			input = input_btn.get_button_state()
			if input.button_id == expected.id:
				if input.button_is_on != expected.is_on:
					failures += 1
				if expected.connection != input.button_connection:
					failures += 1
	if failures > 0:
		print(failures)
		emit_signal("crash")
		_failure_idx = min(failures, _stage["failures"].size() - 1)
		return
	# for now just cycle through the stages
	_set_next_stage()

func update_prompt():
	emit_signal("new_prompt", _stage["prompt"])

func update_instructions():
	var instruction = _stage["instruction"].format(globals.button_id_to_name) 
	emit_signal("new_instructions", instruction)
	#get_node("../HUD").set_text(instruction)

	
func get_result_message() -> String:
	return ""
	# select the correct success / failure message depending on input failures
	return _stage["success"]
