extends MeshInstance

var powerOn : bool = true
var rng

func _ready():
	globals.connect("electrical_power_changed", self, "_electrical_power_changed")
	rng = RandomNumberGenerator.new()
	rng.randomize()

func _electrical_power_changed(on):
	powerOn = on
	_turn_off_lamp($lamps_1, on)
	_turn_off_lamp($lamps_2, on)
	_turn_off_lamp($lamps_3, on)
	_turn_off_lamp($lamps_4, on)
	_turn_off_lamp($lamps_5, on)

func _process(delta):
	if(!powerOn):
		return
	
	_rand_turn_on($lamps_1)
	_rand_turn_on($lamps_2)
	_rand_turn_on($lamps_3)
	_rand_turn_on($lamps_4)
	_rand_turn_on($lamps_5)
	
func _turn_off_lamp(lamp, on):
	lamp.get_surface_material(0).set_shader_param("light_on", on as float)
	
func _rand_turn_on(lamp : MeshInstance):
	if rng.randi_range(0, 100) > 99:
		var previous = lamp.get_surface_material(0).get_shader_param("light_alpha")
		lamp.get_surface_material(0).set_shader_param("light_alpha", 0 if previous > 0 else 1)
