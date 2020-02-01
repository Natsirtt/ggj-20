extends Label

func _ready():
	pass
	
func _on_TextTimer_timeout():
	if visible_characters < text.length():
		visible_characters = visible_characters +1
