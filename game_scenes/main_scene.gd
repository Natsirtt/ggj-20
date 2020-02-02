extends Spatial

func _ready():
	globals.connect("electrical_power_changed", self, "_on_power_changed")

func _on_power_changed(on):
	$Cockpit/SpotLight.light_energy = on as float
	$Cockpit/OmniLight.light_energy = on as float
	$DirectionalLight.light_energy = 0.7 if on else 0.2
	$Cockpit/HUD.visible = on
	$Cockpit/AltHUD.visible = on
	$Cockpit/Prompt.visible = on
