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
	_set_next_stage()
	
func _set_next_stage():
	if stage_cntr < _scenario["stages"].size():
		_stage = _scenario["stages"][stage_cntr]
		update_prompt()
		update_instructions()
	else:
		print("won")
		emit_signal("won")
	stage_cntr += 1
	
func resolve_input(input_array : Array):
	var expected_list = _stage["inputs"]
	if input_array.size() != expected_list.size():
		emit_signal("crash")
		print(" ouch")
	var expected = {}
	var input = null
	var failures = 0
	for idx in range(input_array.size()):
		expected =  expected_list[idx]
		input = input_array[idx]
		if expected.action == "connect":
			if input.button_id != expected.ids[0]:
				if input.connected_to == null:
					failures += 1
					continue
				if input.connected_to.button_id != expected.ids[1]:
					failures += 1
					continue
		elif expected.action == "toggle":
			if input.button_id != expected.id or input.connected_to != null:
				failures += 1
	if failures > 0:
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

	
func get_result_message() -> String:
	return ""
	# select the correct success / failure message depending on input failures
	return _stage["success"]
