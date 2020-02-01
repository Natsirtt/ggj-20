extends Camera

enum Stage {UP, DOWN}

export var shake_strength = 1.0
export (Vector3) var up_stage_rotation = Vector3.ZERO
export (Vector3) var down_stage_rotation = Vector3.ZERO

onready var stage_to_rotation = {
	Stage.UP: up_stage_rotation,
	Stage.DOWN: down_stage_rotation
}

export (Stage) var stage = Stage.UP

func set_stage(new_stage):
	if new_stage != stage:
		stage = new_stage
		set_rotation(stage_to_rotation[stage])

func _process(delta):
	if Input.is_action_just_pressed("camera_down"):
		set_stage(Stage.DOWN)
	elif Input.is_action_just_pressed("camera_up"):
		set_stage(Stage.UP)
