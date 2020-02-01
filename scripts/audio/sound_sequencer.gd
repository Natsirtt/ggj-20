extends Spatial

var mRumble1Start = 0.0
var mRumble1Max = 0.4
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	updateVolume($rumble1,0,0.4)
	updateVolume($rumble2,0.2,0.6)
	updateVolume($rumble3,0.4,0.7)
	updateVolume($rumble4,0.7,0.95)

func updateVolume(sound:AudioStreamPlayer, start, full):
	var distanceToPlanet = globals.normalised_distance_to_planet
	var intensity = range_lerp(distanceToPlanet,0 , 1, 1, 0)
	var volume = range_lerp(intensity, start, full, 0, 1)
	volume = clamp(volume, 0.0, 1.0)
	sound.volume_db = linear2db(volume)
