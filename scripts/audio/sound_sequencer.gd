extends Spatial
var mIntensity = 0.0
var game_over : bool = false
var mPowerOn = true

func _ready():
	globals.connect("game_over", self, "_on_game_over")
	globals.connect("electrical_power_changed", self, "OnPowerChanged")
	globals.connect("crashed", self, "Crash")
	
func OnPowerChanged(on):
	mPowerOn = on
	if	on:
		$powerSounds.powerOn()
	else:
		$powerSounds.powerOff()

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
	updateRFXVolume($RFX,0.4,1)
	StartSound($alarm1,0.3)
	StartSound($alarm2,0.6)
	StartSound($alarm3,0.7)
	StartSound($alarm4,0.9)

func updateVolume(sound:AudioStreamPlayer, start, full):
	var volume = range_lerp(mIntensity, start, full, 0, 1)
	volume = clamp(volume, 0.0, 1.0)
	sound.volume_db = linear2db(volume)
	
func updateRFXVolume(sound:AudioStreamPlayer3D, minVol, maxVol):
	var volume = range_lerp(mIntensity, 0, 1, minVol, maxVol)
	volume = clamp(volume, 0.0, 1.0)
	sound.unit_db = linear2db(volume)

func StartSound(sound:AudioStreamPlayer3D, start):
	if	mPowerOn:
		if !sound.playing && mIntensity > start:
			sound.play()
		
		if sound.playing:
			var volume = range_lerp(mIntensity, 0, 1, 0.5, 1)
			sound.unit_db = linear2db(volume)
	else:
		if sound.playing:
			sound.stop()
			
func Crash():
	$crashSound.play()
