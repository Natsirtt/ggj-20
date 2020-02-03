extends Spatial

export (Dictionary) var node_to_rotation_per_sec

func _process(delta):
	for node_path in node_to_rotation_per_sec:
		var node = get_node(node_path)
		node.set_rotation_degrees(node.get_rotation_degrees() + Vector3(0, node_to_rotation_per_sec[node_path] * delta, 0))
