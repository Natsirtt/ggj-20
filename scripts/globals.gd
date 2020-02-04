extends Node

signal game_over(won)
signal electrical_power_changed(on)
signal crashed

var button_id_to_name = {
	0: "DAP",
	1: "NOO",
	2: "SHI",
	3: "HEL",
	4: "POP",
	5: "PEP",
	6: "001",
	7: "003",
	8: "006",
	9: "100",
	10: "010",
	}

var distance_to_planet = 0.0
var normalised_distance_to_planet = 1.0
# 0 for random scenario. 1 or more to choose specified scenario (error if non existent)
var scenario_number = 1
var last_game_won = null

func reset_game(scenario_num : int):
	distance_to_planet = 0.0
	normalised_distance_to_planet = 1.0
	scenario_number = scenario_num
	last_game_won = null

func _trigger_game_over(var didWeWin : bool):
	last_game_won = didWeWin
	emit_signal("game_over", didWeWin)

func _trigger_electrical_power_changed(var on : bool):
	emit_signal("electrical_power_changed", on)	

func trigger_crash():
	if last_game_won == null:
		emit_signal("crashed")
