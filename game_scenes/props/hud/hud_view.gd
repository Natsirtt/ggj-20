extends Spatial

func _ready():
	pass # Replace with function body.

func set_text(var textString : String):
	$Viewport/Control/RichTextLabel.text = textString
	$Viewport/Control/RichTextLabel.margin_bottom = 0
	$Viewport/Control/RichTextLabel.margin_up = 0
	$Viewport/Control/RichTextLabel.margin_left = 0
	$Viewport/Control/RichTextLabel.margin_right = 0
