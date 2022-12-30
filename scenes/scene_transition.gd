extends CanvasLayer


func change_scene(target: String):
	$AnimationPlayer.play("dissolve")
	yield($AnimationPlayer, "animation_finished")
	# warning-ignore:return_value_discarded
	get_tree().change_scene(target)
	$AnimationPlayer.play_backwards("dissolve")


func reload_current_scene():
	$AnimationPlayer.play("dissolve")
	yield($AnimationPlayer, "animation_finished")
	# warning-ignore:return_value_discarded
	get_tree().reload_current_scene()
	$AnimationPlayer.play_backwards("dissolve")
