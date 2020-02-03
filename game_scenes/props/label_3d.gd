tool
extends Spatial

export(String) var label_text = "default" setget set_label_text
export(Color) var label_color = Color.black setget set_label_color

func set_label_color(color):
	label_color = color
	$Viewport/Control/Label.add_color_override("font_color", label_color)
	
func set_label_text(text):
	label_text = text
	$Viewport/Control/Label.text = text
	$Viewport/Control/Label.margin_bottom = 0
	$Viewport/Control/Label.margin_top = 0
	$Viewport/Control/Label.margin_left = 0
	$Viewport/Control/Label.margin_right = 0
	
func _ready():
	pass # Replace with function body.
