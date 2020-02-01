extends AudioStreamPlayer3D

export(Array, AudioStream) var mSounds
export var mMinTime = 1.0
export var mMaxTime = 4.0

func _ready():
	Reset()
	connect("finished", self, "Reset")

func _process(delta):
	pass
	
func _on_RFXTimer_timeout():
	translation = Vector3( rand_range(-30, 30), 0, 0 )
	var randomSound = int(rand_range(0, mSounds.size()))
	stream = mSounds[randomSound]
	play()
	$RFXTimer.stop()

func Reset():
	$RFXTimer.wait_time = rand_range(mMinTime, mMaxTime)
	$RFXTimer.start()
