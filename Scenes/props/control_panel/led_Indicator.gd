extends MeshInstance

func _on_Button_on_button_toggled(buttonToggledState):
	self.get_surface_material(0).set_shader_param("light_alpha", buttonToggledState as float)
