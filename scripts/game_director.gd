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
signal gameStartup

func get_json_file_paths_in_folder(folder):
	if not folder.ends_with("/"):
		folder += "/"
	var files = []
	var dir = Directory.new()
	dir.open(folder)
	dir.list_dir_begin()
	var file = dir.get_next()
	while file != "":
		if not file.begins_with(".") and file.ends_with(".json"):
			files.push_back(folder + file)
		file = dir.get_next()
	dir.list_dir_end()
	return files

func _ready():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var json_files = get_json_file_paths_in_folder("res://scenarios/")
	var json_path = json_files[rng.randi_range(0, json_files.size() - 1)]
	var file = File.new()
	file.open(json_path, file.READ)
	# TODO should probably check if result is valid, if I had the time
	var foo = file.get_as_text()
	_scenario = JSON.parse(file.get_as_text()).result
	assert(_scenario != null)
	get_node("../ControlPanel").connect("pressed_execute", self, "resolve_input")
	get_node("../Camera").shake_strength = 0
	self.connect("crash", self, "end_game")
	self.connect("won", self, "win_game")
	self.connect("failed_input", self, "power_failure")

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
		if no_match_found && input.button_is_on && input.button_id >= 0:
			failures += 1
	if failures > 0:
		emit_signal("failed_input")
		update_hud_prompt(_stage.failure)
		return
	# for now just cycle through the stages
	_set_next_stage()

func power_failure():
	globals._trigger_electrical_power_changed(false)
	yield(get_tree().create_timer(3), "timeout")
	globals._trigger_electrical_power_changed(true)	

func win_game():
	globals._trigger_game_over(true)
	yield(get_tree().create_timer(2),"timeout")
	get_tree().change_scene("res://game_scenes/win_screen.tscn")
	
func end_game():
	globals._trigger_game_over(false)
	yield(get_tree().create_timer(2),"timeout")
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

func gameStartup():
	emit_signal("gameStartup")
	_set_next_stage()
