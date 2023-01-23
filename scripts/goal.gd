# Abstract goal class.
class_name Goal
extends Area2D


const POSITION_TOLERANCE = 5.0
const SIZE_TOLERANCE = 5.0
const ROTATION_TOLERANCE = PI / 36.0 # +/- 5 degrees
const MATCHING_NOT_ACTIVE = -1.0
const MATCHING_TIMEOUT = 4.0


onready var _countdown: GoalCountdown = $GoalCountdown
var _matched_elements: Array
var _matched_current_element: Element = null
var _match_duration = MATCHING_NOT_ACTIVE


func _ready():
	_countdown.rotation = -rotation


func _process(delta):
	if _matched_current_element != null && _is_matching(_matched_current_element):
		_match_duration += delta
		_countdown.visible = true
		_countdown.set_progress(_match_duration / MATCHING_TIMEOUT)

		if _match_duration >= MATCHING_TIMEOUT:
			Audio.tick_stop()
			_matched_current_element.make_matched()
			Game.goal_accomplished()
			queue_free()
	else:
		if _matched_current_element != null:
			# reset from previous matching
			_matched_current_element = null
			_match_duration = MATCHING_NOT_ACTIVE
			Audio.tick_stop()
			_countdown.visible = false

		for e in _matched_elements:
			if _is_matching(e):
				_matched_current_element = e
				_match_duration = 0
				Audio.tick_start()
				break


func _add_matched_element(element: Element):
	_matched_elements.append(element)
	#print("Matched element entered", element)


func _remove_matched_element(element):
	_matched_elements.erase(element)


func _is_position_matching(pos1: Vector2, pos2: Vector2) -> bool:
	return (pos1 - pos2).length() < POSITION_TOLERANCE


func _is_size_matching(size1: float, size2: float) -> bool:
	return abs(size1 - size2) < SIZE_TOLERANCE


func _is_rotation_matching(rotation1: float, rotation2: float, modulo: float) -> bool:
	var a = fmod(abs(rotation1 - rotation2), modulo)
	var modulo_half = modulo * 0.5
	#a = a if a <= modulo * 0.5 else
	a = modulo_half - abs(modulo_half - a)
	var b = a < ROTATION_TOLERANCE
	return b


# callbacks to override in subclasses
func _is_matching(_element: Element) -> bool: return false
