tool
extends Spatial

export(String) var label_text = "default" setget set_label_text, get_label_text

func set_label_text(text):
	label_text = text
	$Viewport/Control/Label.text = text
	
func get_label_text():
	return label_text
	
func _ready():
	pass # Replace with function body.
