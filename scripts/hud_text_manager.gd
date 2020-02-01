extends Node

func _ready():
	#game_director.connect("state_changed", self, "OnStateChanged")
	OnStateChanged()

func OnStateChanged():
	get_node("../Prompt").visible_characters = -1
	get_node("../Prompt").text = game_director.get_prompt()
	get_node("../Instructions").visible_characters = -1
	get_node("../Instructions").text = game_director.get_instruction()

	get_node("../HudSound").play()

func _on_Timer_timeout():
	if get_node("../Instructions").visible_characters == game_director.get_instruction().length():
		if get_node("../HudSound").playing:
			get_node("../HudSound").stop()
		
