extends Camera

enum Stage {UP, DOWN}

export var shake_strength = 1.0
export (Vector3) var up_stage_rotation = Vector3.ZERO
export (Vector3) var down_stage_rotation = Vector3.ZERO

export (Stage) var stage = Stage.UP

func set_stage(new_stage):
	if new_stage != stage:
		stage = new_stage

func _process(delta):
	pass
