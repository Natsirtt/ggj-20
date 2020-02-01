extends MeshInstance

func _ready():
	pass # Replace with function body.

func _on_Spatial_on_hovered(hoveredState):
	$Tween.interpolate_property(self, "translation:y", null, 0.6 if hoveredState else 0.518, 0.08)
	$Tween.start()

func _on_Spatial_on_toggled(buttonToggledState):
	$Tween.interpolate_property(self, "translation:y", null, 0.37, 0.08)
	$Tween.start()
	yield($Tween, "tween_completed")
	$Tween.interpolate_property(self, "translation:y", null, 0.518, 0.08)
	$Tween.start()
