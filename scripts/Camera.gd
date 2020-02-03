extends Camera

enum Stage {UP, DOWN}

export var shake_strength = 2.0
export var shake_step = 0.015
export (Vector3) var up_stage_rotation = Vector3.ZERO
export (Vector3) var down_stage_rotation = Vector3.ZERO
export (Stage) var stage = Stage.UP
export var rotation_time_sec = 0.5
const transition_type = Tween.TRANS_LINEAR
const easing_type = Tween.EASE_OUT

var shakeFreqX = 20
var shakeFreqY = 8
var shakeFreqY2 = 20
var shakeSizeX = .15
var shakeSizeY = .1
var shakeSizeY2 = .05
var time : float = 0
var game_over : bool = false

onready var stage_to_rotation = {
	Stage.UP: up_stage_rotation,
	Stage.DOWN: down_stage_rotation
}

export (Color) var overlay_color setget _set_overlay_color

func _set_overlay_color(color: Color):
	overlay_color = color
	if $FillScreen != null:
		var mat = $FillScreen.get_surface_material(0)
		mat.set_shader_param("color", Vector3(overlay_color.r, overlay_color.g, overlay_color.b))
		mat.set_shader_param("alpha", overlay_color.a)

func _ready():	
	globals.connect("game_over", self, "_on_game_over")

func _on_game_over(didWeWin):
	game_over = true
	set_stage(Stage.UP)

func set_stage(new_stage):
	if new_stage != stage:
		stage = new_stage
		$Tween.interpolate_property(self, "rotation_degrees", null, stage_to_rotation[stage], rotation_time_sec, transition_type, easing_type)
		$Tween.start()

func _process(delta):
	if game_over:
		pass
		self.h_offset = -self.h_offset * delta * 2
		self.v_offset = -self.h_offset * delta * 2
	else:
		if Input.is_action_just_pressed("camera_down"):
			set_stage(Stage.DOWN)
		elif Input.is_action_just_pressed("camera_up"):
			set_stage(Stage.UP)
		shake_strength = (1 - globals.normalised_distance_to_planet)/1.3
		time += delta
		var xAdjustment = sin( time * shakeFreqX ) * shakeSizeX
		var yAdjustment = sin( time * shakeFreqY ) * shakeSizeY + cos( time*shakeFreqY2 )*shakeSizeY2
		
		self.h_offset = xAdjustment * shake_strength
		self.v_offset = yAdjustment * shake_strength
