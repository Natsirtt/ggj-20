extends AudioStreamPlayer

var mTargetVolume:float
var mDbsToFade
export var mFadeInTime:float = 1.0

func _ready():
	if	mFadeInTime > 0.0:
		FadeIn(volume_db, mFadeInTime)
	
func FadeIn(fadeInVolume, fadeInTime):
	volume_db = -80.0
	SetVolumeOverTime(fadeInVolume, fadeInTime)

func SetVolumeOverTime(volume, time):
	mTargetVolume = volume
	mFadeInTime = time
	mDbsToFade = abs(volume_db) - mTargetVolume
	
func _process(delta):
	if volume_db < mTargetVolume:
		volume_db += mDbsToFade / mFadeInTime * delta
		
