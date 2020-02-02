extends Spatial
export var PlaySounds = false;
export var DelayedPrinting = false;

func _ready():
	pass # Replace with function body.

func set_text(var textString : String):
	$Viewport/Control/RichTextLabel.text = textString
	$Viewport/Control/RichTextLabel.margin_bottom = 0
	$Viewport/Control/RichTextLabel.margin_top = 0
	$Viewport/Control/RichTextLabel.margin_left = 0
	$Viewport/Control/RichTextLabel.margin_right = 0
	if	DelayedPrinting:
		$Viewport/Control/RichTextLabel.visible_characters = -1
		$PrintTimer.start()
	if DelayedPrinting && PlaySounds:
		$TextSounds.play()

func _on_PrintTimer_timeout():
	
	if $Viewport/Control/RichTextLabel.text.length() > $Viewport/Control/RichTextLabel.visible_characters:
		$Viewport/Control/RichTextLabel.visible_characters += 1
	elif PlaySounds:
		$TextSounds.stop()
