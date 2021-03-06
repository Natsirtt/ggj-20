extends Spatial

export var button_id = -1

func _ready():
	get_node("Button").button_id = button_id
	_on_toggled(false)
	
func on_hovered(isHovering : bool):
	get_node("Button").on_hovered(isHovering)
	
func on_toggled(isToggledOn : bool):
	get_node("Button").on_toggled(isToggledOn)

func is_button_on() -> bool:
	return get_node("Button").is_button_on()
	
func get_button_state():
	return get_node("Button").get_button_state()

func reset_button():
	return get_node("Button").reset_button()
	
func _on_toggled(buttonToggledState):
	$LED_Indicator.get_surface_material(0).set_shader_param("light_alpha", buttonToggledState as float)
