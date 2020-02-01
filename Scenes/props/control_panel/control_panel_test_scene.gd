extends Spatial
var timer

func _ready():
	timer = Timer.new()
	add_child(timer)
	timer.wait_time = 0.5
	timer.connect("timeout", self, "_test_button_toggle")
	timer.start()
	
func _test_button_toggle():
	var btn = get_node("PanelMesh/Button")
	btn.on_button_toggled(!btn.is_button_on())
