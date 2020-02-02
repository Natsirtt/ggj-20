extends Spatial

func _ready():
	globals.connect("electrical_power_changed", self, "_on_power_changed")

func _on_power_changed(on):
	$Cockpit/OmniLight.light_energy = on as float
	$Cockpit/SpotLight.light_energy =  3.62 if on else 0.2
	$DirectionalLight.light_energy = 0.7 if on else 0.2
	$Cockpit/HUD.visible = on
	$Cockpit/AltHUD.visible = on
	$Cockpit/Prompt.visible = on
