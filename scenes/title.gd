extends Node


var _is_settings_open := false


func _ready():
	Game.is_scene_just_opening = false
	_set_achieved_level()
	Audio.tick_reset()
	$LabelsAndButtons/PressKeyLabel.text = "tap to start" if OS.get_name() == "Android" \
			else "press any key to start"

	if Game.is_title_first_time:
		$AnimationPlayer.play("appear")
		Game.is_title_first_time = false


func _set_achieved_level():
	if  Game.current_level > 0:
		$LabelsAndButtons/AchievedLevelLabel.text = "Achieved level: %d" % Game.current_level
	else:
		$LabelsAndButtons/AchievedLevelLabel.text = ""


func _unhandled_input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		if _is_settings_open:
			_on_OkButton_pressed()
		else:
			get_tree().quit()
	elif Input.is_action_just_pressed("ui_accept") && _is_settings_open:
		_on_OkButton_pressed()
	elif event.is_pressed() && !_is_settings_open:
		_is_settings_open = true # hack to filter multiple taps on Android
		Audio.button_click()
		Game.goto_next_level()


func _on_ExitButton_pressed():
	get_tree().quit()


func _on_SettingsButton_pressed():
	_is_settings_open = true
	Audio.button_click()
	$SettingsDialog.popup()
	$SettingsDialog/MusicSlider.value = Audio.music_volume
	$SettingsDialog/MusicSprite.animation = "off" if Audio.music_volume < 0.01 else "on"
	$SettingsDialog/FxSlider.value = Audio.fx_volume
	$SettingsDialog/FxSprite.animation = "off" if Audio.fx_volume < 0.01 else "on"


func _on_MusicSlider_value_changed(value):
	Audio.set_volumes(value, -1)
	$SettingsDialog/MusicSprite.animation = "off" if value < 0.01 else "on"


func _on_FxSlider_value_changed(value):
	Audio.set_volumes(-1, value)
	Audio.button_click()
	$SettingsDialog/FxSprite.animation = "off" if value < 0.01 else "on"


func _on_ResetLevelButton_pressed():
	Audio.button_click()
	Game.current_level = 0
	Game.save_current_level()
	_set_achieved_level()


func _on_OkButton_pressed():
	_is_settings_open = false
	Game.save_audio_settings()
	Audio.button_click()
	$SettingsDialog.hide()
