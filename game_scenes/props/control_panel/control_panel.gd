extends Spatial

signal pressed_execute(buttons)

export var start_arms_shake_normalised_distance_threshold = 0.7

var _buttons : Array
var current_button = null
var is_power_on : bool = true

func _electrical_power_changed(on):
	is_power_on = on

func _input(event : InputEvent):
	var camera = get_node("../Camera")
	if camera.stage == camera.Stage.UP:
		return
	if(event.is_action_pressed("ui_down")):
		down()
	if(event.is_action_pressed("ui_up")):
		up()
	if(event.is_action_pressed("ui_right")):
		right()
	if(event.is_action_pressed("ui_left")):
		left()
	if(event.is_action_pressed("ui_accept")):
		select()

func _on_game_over(didWeWin):
	$AnimationPlayer.stop(true)
	
func _ready():
	_buttons = _find_buttons(get_children())
	
	for button in _buttons:
		print(button.get_name())
	
	left()
	$AnimationPlayer.play("Arm shake")
	
	globals.connect("game_over", self, "_on_game_over")
	globals.connect("electrical_power_changed", self, "_electrical_power_changed")

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
	_find_switch_in_direction(Vector3.FORWARD)
	
func down():
	_find_switch_in_direction(Vector3.BACK)

func left():
	_find_switch_in_direction(Vector3.LEFT)

func right():
	_find_switch_in_direction(Vector3.RIGHT)
	
func select():
	if current_button != null:
		current_button.on_toggled( !current_button.is_button_on() )
	
func _find_nearest_switch(var direction : Vector3):
	var our_pos = current_button.global_transform.origin
	var best_score_so_far = 0
	var nearest_switch = null
	for button in _buttons:
		var their_pos = button.global_transform.origin
		var vec_to_them : Vector3 = (their_pos - our_pos)
		vec_to_them.y = 0
		var dot = vec_to_them.normalized().dot(direction)
		if dot <= 0.4:
			continue
		var distance = vec_to_them.length()
		var score = (1 / (distance + 1))
		if score > best_score_so_far:
			best_score_so_far = score
			nearest_switch = button
	return nearest_switch

func _find_switch_in_direction(var direction : Vector3):
	if _buttons.size() <= 0:
		pass
		
	if current_button == null:
		current_button = _buttons[0]
		current_button.on_hovered(true)
	else:
		var new_button = _find_nearest_switch(direction)
		if new_button != null:
			current_button.on_hovered(false)
			current_button = new_button
			current_button.on_hovered(true)

func _on_ExecuteButton_on_toggled(buttonToggledState):
	if buttonToggledState:
		if is_power_on:
			emit_signal("pressed_execute", _buttons)
			
		for button in _buttons:
			if button != current_button:
				button.reset_button()
			else:
				button.reset_toggled()

func _process(delta):
	var shakeAlpha = 1 - clamp(globals.normalised_distance_to_planet / start_arms_shake_normalised_distance_threshold, 0, 1)
	$AnimationPlayer.playback_speed = shakeAlpha * 1.4
