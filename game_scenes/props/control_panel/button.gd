extends MeshInstance

signal on_hovered(hoveredState)
signal on_toggled(buttonToggledState)

export var button_id = -1
var _is_button_on : bool
var _is_button_hovered : bool

class ButtonState:
	var button_id = -1
	var button_is_on = false
	var button_connection = null
	
func on_hovered(isHovering : bool):
	emit_signal("on_hovered", isHovering)
	_is_button_hovered = isHovering
	translation.y += 15 if isHovering == true else -15
	
func on_toggled(isToggledOn : bool):
	emit_signal("on_toggled", isToggledOn)
	_is_button_on = isToggledOn

func is_button_on() -> bool :
	return _is_button_on
	
func get_button_state():
	var btnState = ButtonState.new()
	btnState.button_id = button_id
	btnState.button_is_on = is_button_on()
	btnState.button_connection = null
	return btnState

func reset_button():
	_is_button_on = false
	_is_button_hovered = false
