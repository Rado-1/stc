extends Node


func _ready():
	Game.is_scene_just_opening = false
	Audio.tick_reset()
	$PressKeyLabel.text = "tap to return" if OS.get_name() == "Android" \
			else "press any key to return"



func _unhandled_input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
	elif event.is_pressed():
		# warning-ignore:return_value_discarded
		SceneTransition.change_scene("res://scenes/title.tscn")


func _on_LinkButton_pressed():
	if Game.is_scene_just_opening:
		return

	Game.is_scene_just_opening = true
	# warning-ignore:return_value_discarded
	OS.shell_open("https://github.com/Rado-1/stc")
