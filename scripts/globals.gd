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

func _trigger_game_over(var didWeWin : bool):
	emit_signal("game_over", didWeWin)

func _trigger_electrical_power_changed(var on : bool):
	emit_signal("electrical_power_changed", on)	

func trigger_crash():
	emit_signal("crashed")
