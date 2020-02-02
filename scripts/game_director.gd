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
signal failed_input

func _ready():
	var file = File.new()
	file.open("res://scenarios/crash_001.json", file.READ)
	# TODO should probably check if result is valid, if I had the time
	_scenario = JSON.parse(file.get_as_text()).result
	get_node("../ControlPanel").connect("pressed_execute", self, "resolve_input")
	get_node("../Camera").shake_strength = 0
	self.connect("crash", self, "end_game")
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
		update_hud_prompt("LANDED")
	stage_cntr += 1

func update_hud_prompt(text : String):
	get_node("../Prompt").set_text(text)

func update_alt_prompt(text : String):
	get_node("../AltHUD").set_text(text)

func resolve_input(input_array : Array):
	var expected_list = _stage["inputs"]
	var height_limits = _stage["height"]
	if height_limits != []:
		# height limits should be max, min
		if height_limits[0] > globals.distance_to_planet or height_limits[1] < globals.distance_to_planet:
			emit_signal("crash")
			end_game()
			return
	var expected = {}
	var input = null
	var failures = 0
	for input_btn in input_array:
		input = input_btn.get_button_state()
		var no_match_found = true
		for idx in range(expected_list.size()):
			expected =  expected_list[idx]
			if input.button_id == expected.id:
				no_match_found = false
				if !input.button_is_on:
					failures += 1
		if no_match_found && input.button_is_on:
			failures += 1
	if failures > 0:
		emit_signal("failed_input")
		update_hud_prompt(_stage.failure)
		return
	# for now just cycle through the stages
	_set_next_stage()

func end_game():
	get_tree().change_scene("res://game_scenes/menu.tscn")

func update_prompt():
	emit_signal("new_prompt", _stage["prompt"])
	update_hud_prompt(_stage["prompt"])

func update_instructions():
	var instruction = _stage["instruction"].format(globals.button_id_to_name)
	emit_signal("new_instructions", instruction)
	get_node("../HUD").set_text(instruction)

func get_result_message() -> String:
	return ""
	# select the correct success / failure message depending on input failures
	return _stage["success"]

func _process(delta):
	if globals.normalised_distance_to_planet < 0.01:
		emit_signal("crash")
	update_alt_prompt(round(globals.distance_to_planet) as String + " units")

