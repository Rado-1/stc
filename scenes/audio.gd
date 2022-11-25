extends Node


const MATCHED_01 = preload("res://assets/audio/nice.mp3")
const MATCHED_02 = preload("res://assets/audio/awesome.mp3")
const MATCHED_03 = preload("res://assets/audio/great.mp3")
const MATCHED_04 = preload("res://assets/audio/keep_working.mp3")
const MATCHED_05 = preload("res://assets/audio/nice_work.mp3")
const MATCHED_06 = preload("res://assets/audio/perfect.mp3")
const MATCHED_07 = preload("res://assets/audio/wow.mp3")
const MATCHED_08 = preload("res://assets/audio/you_did_it.mp3")
const MATCHED_09 = preload("res://assets/audio/yes.mp3")
const MATCHED_10 = preload("res://assets/audio/yes_you_did_it.mp3")
const MATCHED_11 = preload("res://assets/audio/nice_but_some_more_remain.mp3")
const _match_streams = [
		MATCHED_01, MATCHED_02, MATCHED_03, MATCHED_04, MATCHED_05, MATCHED_06,
		MATCHED_07, MATCHED_08, MATCHED_09, MATCHED_10, MATCHED_11
]
const _match_streams_count = 11


onready var _music: AudioStreamPlayer = $MusicPlayer
onready var _button_click: AudioStreamPlayer = $ButtonClickPlayer
onready var _element_new: AudioStreamPlayer = $ElementNewPlayer
onready var _element_done: AudioStreamPlayer = $ElementDonePlayer
onready var _tick: AudioStreamPlayer = $TickPlayer
onready var _matched: AudioStreamPlayer = $MatchedPlayer
onready var _level_accomplished: AudioStreamPlayer = $LevelAccomplishedPlayer
var _music_bus_index = 2 #AudioServer.get_bus_index("Music")
var _fx_bus_index = 1 #AudioServer.get_bus_index("FX")
var _music_playback_position := 0.0
var _tick_number := 0
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


func tick_reset():
	_tick_number = 0
	call_deferred("_tick_stop")


func tick_start():
	_tick_number += 1
	#print("TICK START", _tick_number)
	if _tick_number == 1:
		_tick.play()


func tick_stop():
	if _tick_number > 0:
		_tick_number -= 1
	#print("TICK STOP", _tick_number)
	if _tick_number == 0:
		_tick.playing = false
		call_deferred("_tick_stop")


func _tick_stop():
	_tick.stop()


func matched():
	_matched.stream = _match_streams[randi() % _match_streams_count]
	_matched.play()


func level_accomplished():
	_level_accomplished.play()


func set_volumes(music_vol: float, fx_vol: float):
	if music_vol >= 0.0:
		music_volume = music_vol
		AudioServer.set_bus_mute(_music_bus_index, music_vol < 0.01)
		AudioServer.set_bus_volume_db(_music_bus_index, linear2db(music_vol))

	if fx_vol >= 0.0:
		fx_volume = fx_vol
		AudioServer.set_bus_mute(_fx_bus_index, fx_vol < 0.01)
		AudioServer.set_bus_volume_db(_fx_bus_index, linear2db(fx_vol))


func _notification(what):
	match what:
		NOTIFICATION_WM_FOCUS_IN:
			_music.play(_music_playback_position)
		NOTIFICATION_WM_FOCUS_OUT:
			_music_playback_position = _music.get_playback_position()
			_music.stop()
