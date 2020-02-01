extends MeshInstance

func _ready():
	_on_Body_on_toggled(false)

func _on_Body_on_toggled(buttonToggledState):
	self.get_surface_material(0).set_shader_param("light_alpha", buttonToggledState as float)
