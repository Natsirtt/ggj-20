extends Spatial

export var earth_rotation_per_sec = 0.5
export var clouds_rotation_per_sec = 2.0

func _process(delta):
	$planet.set_rotation_degrees($planet.get_rotation_degrees() + Vector3(0, earth_rotation_per_sec * delta, 0))
	$clouds.set_rotation_degrees($clouds.get_rotation_degrees() + Vector3(0, clouds_rotation_per_sec * delta, 0))
