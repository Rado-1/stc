class_name GoalCountdown
extends Node2D


const ANGLE_TOP = -TAU / 4.0
const ANGLE_FULL = TAU * 1.1


var _value: float


func set_progress(value: float):
	_value = value * TAU + ANGLE_TOP
	update()


func _draw():
	draw_arc(Vector2.ZERO, 20.0, 0.0, ANGLE_FULL, 32, Color.beige, 10.0, true)
	draw_arc(Vector2.ZERO, 20.0, ANGLE_TOP, _value, 32, Color.crimson, 8.0, true)
