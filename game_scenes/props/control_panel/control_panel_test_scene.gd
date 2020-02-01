extends Spatial
var timer

func _ready():
	pass
	
func _test_button_toggle():
	var btn = get_node("ControlPanel/Switch/Button")
	btn.on_toggled(!btn.is_button_on())
