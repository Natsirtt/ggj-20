extends Spatial
var mIntensity = 0.0
var game_over : bool = false

func _ready():
	globals.connect("game_over", self, "_on_game_over")

func _on_game_over(didWeWin):
	game_over = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if game_over:
		mIntensity = -mIntensity * delta * 2
	else:
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
