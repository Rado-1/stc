# Global game singleton.
extends Node


enum {CIRCLE, SQUARE, TRIANGLE}
const CONFIG_FILE = "user://stc.cfg"
const GLOBAL_SECTION = "global"
const LEVEL_KEY = "achieved_level"
const MUSIC_VOLUME_KEY = "music_volume"
const FX_VOLUME_KEY = "fx_volume"


var selected_shape
var current_level: int
var _goal_count: int
var _hud: Hud
var _config = ConfigFile.new()
var is_scene_just_opening := false # scene opening lock
var is_level_accomplished: bool


func _init():
	Input.use_accumulated_input = true

	# load config
	_config.load(CONFIG_FILE)
	current_level = _config.get_value(GLOBAL_SECTION, LEVEL_KEY, 0)
	Audio.set_volumes(
			_config.get_value(GLOBAL_SECTION, MUSIC_VOLUME_KEY, 0.5),
			_config.get_value(GLOBAL_SECTION, FX_VOLUME_KEY, 0.5))


func save_current_level():
	_config.set_value(GLOBAL_SECTION, LEVEL_KEY, current_level)
	_config.save(CONFIG_FILE)


func save_audio_settings():
	_config.set_value(GLOBAL_SECTION, MUSIC_VOLUME_KEY, Audio.music_volume)
	_config.set_value(GLOBAL_SECTION, FX_VOLUME_KEY, Audio.fx_volume)
	_config.save(CONFIG_FILE)


func goto_next_level():
	if is_scene_just_opening:
		return

	is_scene_just_opening = true
	save_current_level()

	# increment level
	current_level += 1
	var level_file = "res://levels/%03d.tscn" % current_level

	if ResourceLoader.exists(level_file):
		# warning-ignore:return_value_discarded
		get_tree().change_scene(level_file)
	else:
		current_level -= 1
		# warning-ignore:return_value_discarded
		get_tree().change_scene("res://scenes/end.tscn")


func set_hud(hud):
	_hud = hud


func set_goal_number(number: int):
	_goal_count = number


func goal_accomplished():
	_goal_count -= 1
	if _goal_count == 0:
		is_level_accomplished = true
		_hud.level_accomplished()
		Audio.level_accomplished()
	else:
		Audio.matched()
