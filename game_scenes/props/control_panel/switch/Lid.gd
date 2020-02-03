extends MeshInstance

func _on_Body_on_hovered(hoveredState):
	$Tween.interpolate_property(self, "rotation_degrees:x", null, 0 if hoveredState == true else 90, 0.1)
	$Tween.start()
