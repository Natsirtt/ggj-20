extends AudioStreamPlayer

export(Array, AudioStream) var mSelectSounds
export(Array, AudioStream) var mMiddleButtonSounds
export var mOnSound:AudioStream
export var mOffSound:AudioStream


func _ready():
	pass # Replace with function body.

func playSelectSound():
	var sound = int(rand_range(0, mSelectSounds.size()))
	stream = mSelectSounds[sound]
	play()
	
func playToggleSound(isOn):
	if	isOn:
		stream = mOnSound
		play()
	else:
		stream = mOffSound
		play()
	
func playMiddlePush():
	var sound = int(rand_range(0, mMiddleButtonSounds.size()))
	stream = mMiddleButtonSounds[sound]
	play()
