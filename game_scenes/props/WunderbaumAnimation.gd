extends AnimationPlayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	self.play("WunderbaumLight")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if globals.normalised_distance_to_planet < 0.8:
		self.play("WunderbaumMedium")
	if globals.normalised_distance_to_planet < 0.3:
		self.play("WunderbaumHard")
