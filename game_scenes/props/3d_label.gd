tool
extends MeshInstance

export(String) var label_text = "default" setget changed_label_text

func changed_label_text(value):
	var labelNode = get_node("Viewport/Label")
	labelNode.text = value
	labelNode.margin_bottom = 0
	labelNode.margin_left = 0
	labelNode.margin_right = 0
	labelNode.margin_top = 0

func _ready():
	get_node("Viewport/Label").text = label_text
