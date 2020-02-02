extends MeshInstance

func _ready():
	_on_Body_on_toggled(false)
	globals.connect("electrical_power_changed", self, "_electrical_power_changed")

func _on_Body_on_toggled(buttonToggledState):
	self.get_surface_material(0).set_shader_param("light_alpha", buttonToggledState as float)

func _electrical_power_changed(on):
	self.get_surface_material(0).set_shader_param("light_on", on as float)
