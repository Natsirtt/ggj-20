extends MeshInstance

signal on_button_hovered(hoveredState)
signal on_button_toggled(buttonToggledState)

var _is_button_on : bool
var _is_button_hovered : bool
	
func on_button_hovered(isHovering : bool):
	emit_signal("on_button_hovered", isHovering)
	_is_button_hovered = isHovering
	translation.y += 15 if isHovering == true else -15
	
func on_button_toggled(isToggledOn : bool):
	emit_signal("on_button_toggled", isToggledOn)
	_is_button_on = isToggledOn

func is_button_on() -> bool :
	return _is_button_on
