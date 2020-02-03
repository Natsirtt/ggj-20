extends MeshInstance

signal on_hovered(hoveredState)
signal on_toggled(buttonToggledState)

export var button_id = -1
var _is_button_on : bool
var _is_button_hovered : bool
var _mute_sounds : bool = false

class ButtonState:
	var button_id = -1
	var button_is_on = false
	
func on_hovered(isHovering : bool):
	_is_button_hovered = isHovering
	emit_signal("on_hovered", isHovering)
	if !_mute_sounds:
		$sounds.playSelectSound()
	
func on_toggled(isToggledOn : bool):
	_is_button_on = isToggledOn
	emit_signal("on_toggled", isToggledOn)
	if !_mute_sounds:
		$sounds.playToggleSound(isToggledOn)

func is_button_on() -> bool :
	return _is_button_on
	
func get_button_state():
	var btnState = ButtonState.new()
	btnState.button_id = button_id
	btnState.button_is_on = is_button_on()
	return btnState

func reset_button():
	_mute_sounds = true
	if _is_button_hovered:
		on_hovered(false)
	if _is_button_on:
		on_toggled(false)
	_mute_sounds = false
	
func reset_toggled():
	_mute_sounds = true
	on_toggled(false)
	_mute_sounds = false	
	
func reset_button_w_bool(var flag : bool):
	if flag:
		reset_button()
