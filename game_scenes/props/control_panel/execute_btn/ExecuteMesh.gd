extends MeshInstance

func _ready():
	pass # Replace with function body.

func _on_Spatial_on_toggled(buttonToggledState):
	$Tween.interpolate_property(self, "translation:y", null, 0.42, 0.08)
	$Tween.start()
	yield($Tween, "tween_completed")
	$Tween.interpolate_property(self, "translation:y", null, 0.518, 0.08)
	$Tween.start()
