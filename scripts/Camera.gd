extends Camera

enum Stage {UP, DOWN}

export var shake_strength = 1.0
export (Vector3) var up_stage_rotation = Vector3.ZERO
export (Vector3) var down_stage_rotation = Vector3.ZERO
export (Stage) var stage = Stage.UP
export var rotation_time_sec = 0.5
const transition_type = Tween.TRANS_LINEAR
const easing_type = Tween.EASE_OUT

onready var stage_to_rotation = {
	Stage.UP: up_stage_rotation,
	Stage.DOWN: down_stage_rotation
}

func set_stage(new_stage):
	if new_stage != stage:
		stage = new_stage
		$Tween.interpolate_property(self, "rotation:x", get_rotation().x, stage_to_rotation[stage].x, rotation_time_sec, transition_type, easing_type)
		$Tween.start()

func _process(delta):
	if Input.is_action_just_pressed("camera_down"):
		set_stage(Stage.DOWN)
	elif Input.is_action_just_pressed("camera_up"):
		set_stage(Stage.UP)
