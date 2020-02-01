extends Spatial

export var speed = 20
export var speed_increase_per_seconds = 1
export (NodePath) var destination
onready var destination_node = get_node(destination)
onready var start_altitude = get_global_transform().origin.distance_to(destination_node.get_global_transform().origin)

func update_distance_to_planet():
	globals.distance_to_planet = get_global_transform().origin.distance_to(destination_node.get_global_transform().origin)
	globals.normalised_distance_to_planet = globals.distance_to_planet / start_altitude
	if globals.normalised_distance_to_planet <= 0.80:
		$Particles.set_emitting(true)
	if globals.normalised_distance_to_planet <= 0.40:
		$Particles.amount(100)

func _ready():
	update_distance_to_planet()

func _process(delta):
	var direction = destination_node.get_global_transform().origin - get_global_transform().origin
	global_transform.origin = get_global_transform().origin + direction.normalized() * speed * delta
	speed += speed_increase_per_seconds * delta
	update_distance_to_planet()
