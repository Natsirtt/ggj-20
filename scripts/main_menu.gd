extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export(String) var scene = "res://game_scenes/main_scene.tscn"

# Called when the node enters the scene tree for the first time.
func _ready():
	#get_node("../Label3D").set_label_text("Press 'A' to Start")
	pass

func _input(event):
	if(event.is_action_pressed("ui_accept")):
		get_tree().change_scene(scene)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
