extends AudioStreamPlayer
export(Array, AudioStream) var mPowerOffSounds
export var mOnSound:AudioStream

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func powerOn():
	volume_db = -10
	stream = mOnSound
	play()
	
func powerOff():
	volume_db = 0
	var sound = int(rand_range(0, mPowerOffSounds.size()))
	stream = mPowerOffSounds[sound]
	play()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
