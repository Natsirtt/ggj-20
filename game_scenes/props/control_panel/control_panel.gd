extends MeshInstance

var _buttons : Array

var current_button = null

func _input(event : InputEvent):
	if(event.is_action_pressed("ui_down")):
		down()
	if(event.is_action_pressed("ui_up")):
		up()
	if(event.is_action_pressed("ui_right")):
		right()
	if(event.is_action_pressed("ui_left")):
		left()

func _ready():
	_buttons = _find_buttons(get_children())
	
	for button in _buttons:
		print(button.get_name())
	
	up()

func _find_buttons(var candidates : Array) -> Array:
	var result : Array
	for candidate in candidates:
		if ("button_id" in candidate):
			result.push_back(candidate)
		else:
			var candidateChildren : Array = candidate.get_children()
			if candidateChildren.size() > 0:
				result += _find_buttons(candidateChildren)
	return result

func up():
	_find_switch_in_direction(Vector3.BACK)
	
func down():
	_find_switch_in_direction(Vector3.FORWARD)

func left():
	_find_switch_in_direction(Vector3.RIGHT)

func right():
	_find_switch_in_direction(Vector3.LEFT)
	
func select():
	if current_button != null:
		current_button.on_toggled( current_button.is_button_on() )
	
func _find_nearest_switch(var direction : Vector3):
	var our_pos = current_button.translation
	var best_score_so_far = 999999999999
	var nearest_switch = null
	for button in _buttons:
		var their_pos = button.translation
		var vec_to_them : Vector3 = (their_pos - our_pos)
		var dot = vec_to_them.normalized().dot(direction)
		var distance = vec_to_them.length()
		var score = dot * (1 / (distance + 1))
		if score < best_score_so_far:
			best_score_so_far = score
			nearest_switch = button
	return nearest_switch

func _find_switch_in_direction(var direction : Vector3):
	if _buttons.size() <= 0:
		pass
		
	if current_button == null:
		current_button = _buttons[0]
	else:
		current_button.on_hovered(false)
		current_button = _find_nearest_switch(direction)
	
	current_button.on_hovered(true)
	
