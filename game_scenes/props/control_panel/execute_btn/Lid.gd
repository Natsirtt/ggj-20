extends MeshInstance

func _on_ExecuteBtn_on_hovered(hoveredState):
	$Tween.interpolate_property(self, "rotation_degrees:x", null, 0 if hoveredState == false else -90, 0.1)
	$Tween.start()
