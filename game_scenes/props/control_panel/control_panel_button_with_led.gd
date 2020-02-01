extends Spatial

export var button_id = -1

func _ready():
	get_node("Button").button_id = button_id
