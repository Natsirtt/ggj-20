extends Spatial
var mIntensity = 0.0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	mIntensity = range_lerp(globals.normalised_distance_to_planet, 0, 1, 1, 0)
	updateVolume($rumble1,0,0.4)
	updateVolume($rumble2,0.2,0.6)
	updateVolume($rumble3,0.4,0.7)
	updateVolume($rumble4,0.7,0.95)
	StartSound($alarm1,0.3)
	StartSound($alarm2,0.6)
	StartSound($alarm3,0.7)
	StartSound($alarm4,0.9)

func updateVolume(sound:AudioStreamPlayer, start, full):
	var volume = range_lerp(mIntensity, start, full, 0, 1)
	volume = clamp(volume, 0.0, 1.0)
	sound.volume_db = linear2db(volume)

func StartSound(sound:AudioStreamPlayer3D, start):
	if !sound.playing && mIntensity > start:
		sound.play()
