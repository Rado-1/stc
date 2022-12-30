class_name Hud
extends CanvasLayer


func _ready():
	$LevelLabel.text = "Level  %d" %  Game.current_level


func update_counters(circle_count, square_count, triangle_count):
	_set_counter($ButtonContainer/CircleButton/CircleCountLabel, circle_count)
	_set_counter($ButtonContainer/SquareButton/SquareCountLabel, square_count)
	_set_counter($ButtonContainer/TriangleButton/TriangleCountLabel, triangle_count)


func select_button(shape):
	Game.selected_shape = shape

	match shape:
		Game.CIRCLE:
			$ButtonContainer/CircleButton.pressed = true
		Game.SQUARE:
			$ButtonContainer/SquareButton.pressed = true
		Game.TRIANGLE:
			$ButtonContainer/TriangleButton.pressed = true


func _set_counter(label: Label, number):
	if number == null :
		return
	elif number < 0:
		label.text = ""
	elif number == 0:
		var b = label.get_parent() as TextureButton

		label.text = ""
		b.disabled = true
		b.mouse_default_cursor_shape = Control.CURSOR_FORBIDDEN
		if b.pressed:
			# WORKING HERE - enable the 1st enabled button ???
			pass
	else:
		label.text = str(number)


func level_accomplished():
	$DoneContainer.visible = true
	$ButtonContainer/CircleButton.disabled = true
	$ButtonContainer/SquareButton.disabled = true
	$ButtonContainer/TriangleButton.disabled = true
	$ButtonContainer/CircleButton/CircleCountLabel.visible = false
	$ButtonContainer/SquareButton/SquareCountLabel.visible = false
	$ButtonContainer/TriangleButton/TriangleCountLabel.visible = false


func _on_CircleButton_pressed():
	Audio.button_click()
	Game.selected_shape = Game.CIRCLE


func _on_RectangleButton_pressed():
	Audio.button_click()
	Game.selected_shape = Game.SQUARE


func _on_TriangleButton_pressed():
	Audio.button_click()
	Game.selected_shape = Game.TRIANGLE


#func _set_button_glow():
#	$ButtonContainer/CircleButton.self_modulate = \
#			MODULATE_GLOW if Game.selected_shape == Game.CIRCLE \
#			else MODULATE_NORMAL
#	$ButtonContainer/SquareButton.self_modulate = \
#			MODULATE_GLOW if Game.selected_shape == Game.SQUARE \
#			else MODULATE_NORMAL
#	$ButtonContainer/TriangleButton.self_modulate = \
#			MODULATE_GLOW if Game.selected_shape == Game.TRIANGLE \
#			else MODULATE_NORMAL


func _on_BackButton_pressed():
	Audio.button_click()
	Game.current_level -= 1
	# warning-ignore:return_value_discarded
	SceneTransition.change_scene("res://scenes/title.tscn")


func _on_RetryButton_pressed():
	Audio.button_click()
	# warning-ignore:return_value_discarded
	SceneTransition.reload_current_scene()


func _on_NextLevelButton_pressed():
	Audio.button_click()
	Game.goto_next_level()
