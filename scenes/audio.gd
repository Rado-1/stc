extends Node


onready var _music: AudioStreamPlayer = $MusicPlayer
onready var _button_click: AudioStreamPlayer = $ButtonClickPlayer
onready var _element_new: AudioStreamPlayer = $ElementNewPlayer
onready var _element_done: AudioStreamPlayer = $ElementDonePlayer
onready var _matched: AudioStreamPlayer = $MatchedPlayer
onready var _level_accomplished: AudioStreamPlayer = $LevelAccomplishedPlayer
var _music_bus_index = 2 #AudioServer.get_bus_index("Music")
var _fx_bus_index = 1 #AudioServer.get_bus_index("FX")
var music_volume: float
var fx_volume: float


func play_music():
	_music.play()


func button_click():
	_button_click.play()


func element_new():
	_element_new.play()


func element_done():
	_element_done.play()


func matched():
	_matched.play()


func level_accomplished():
	_level_accomplished.play()


func _volume_to_db(volume: float):
	return -50 + volume * 0.5


func set_volumes(music_vol: float, fx_vol: float):
	if music_vol >= 0.0:
		music_volume = music_vol
		AudioServer.set_bus_mute(_music_bus_index, music_vol < 0.01)
		AudioServer.set_bus_volume_db(_music_bus_index, linear2db(music_vol))

	if fx_vol >= 0.0:
		fx_volume = fx_vol
		AudioServer.set_bus_mute(_fx_bus_index, fx_vol < 0.01)
		AudioServer.set_bus_volume_db(_fx_bus_index, linear2db(fx_vol))
