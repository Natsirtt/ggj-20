extends MeshInstance

func _on_Body_on_toggled(buttonToggledState):
	$Tween.interpolate_property(self, "rotation_degrees:x", null, -45 if buttonToggledState == true else 45, 0.1)
	$Tween.start()
