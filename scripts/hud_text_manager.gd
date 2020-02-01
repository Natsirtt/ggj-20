extends Node

func _ready():
	game_director.connect("state_changed", self, "OnStateChanged")

func OnStateChanged():
	$Prompt.visible_characters = -1
	$Prompt.text = game_director.get_prompt()
	$Instructions.visible_characters = -1
	$Instructions.text = game_director.get_instruction()

	$HudSound.Play()

func _on_Timer_timeout():
	if $Instructions.visible_characters == game_director.get_instruction().length():
		if $HudSound.playing:
			$HudSound.Stop()
		
