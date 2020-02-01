extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var _scenario = {}
var _stage = {}
var stage_cntr = 0

# SIGNALS
signal stage_changed
signal crash
signal won

# Called when the node enters the scene tree for the first time.
func _ready():
	var file = File.new()
	file.open("res://scenarios/crash_001.json", file.READ)
	# TODO should probably check if result is valid, if I had the time
	_scenario = JSON.parse(file.get_as_text()).result
	_set_next_stage()
	
func _set_next_stage():
	if stage_cntr < _scenario["stages"].size():
		_stage = _scenario["stages"][stage_cntr]
		print(_stage["prompt"])
		print(_scenario["stages"].size())
	else:
		emit_signal("won")
	
func resolve_input(input_array : Array):
	# for now just cycle through the stages
	if true:
		_set_next_stage()
	emit_signal("stage_changed")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
