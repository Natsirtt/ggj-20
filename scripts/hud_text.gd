extends Label

export var HudType = "prompt"

func _ready():
	game_director.connect("state_changed", self, "OnStateChanged")

func OnStateChanged():
	if	HudType == "prompt":
		text = game_director.get_prompt()
	if	HudType == "instructions":
		text = game_director.get_instructions()

func _on_Timer_timeout():
	visible_characters = visible_characters +1
