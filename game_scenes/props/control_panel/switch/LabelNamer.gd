extends Spatial

func _ready():
	var button_id = get_node("../").button_id
	if(button_id >= 0):
		$Label3D.label_text = globals.button_id_to_name[button_id]
