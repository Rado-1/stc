class_name Level
extends Node


const HudScene = preload("res://scenes/hud.tscn")
const Circle = preload("res://objects/elements/circle.tscn")
const Square = preload("res://objects/elements/square.tscn")
const Triangle = preload("res://objects/elements/triangle.tscn")
const UNLIMITED = -1


export(int, -1, 100) var max_circles = UNLIMITED
export(int, -1, 100) var max_squares = UNLIMITED
export(int, -1, 100) var max_triangles = UNLIMITED
var _circles_count: int
var _square_count: int
var _triangle_count: int


# used to eliminate createion of multiple objects without releasing LMB
var _can_cerate := true
var _hud: Hud


func _ready():
	Game.is_scene_just_opening = false
	Game.is_level_accomplished = false

	# add hud
	_hud = HudScene.instance()
	add_child(_hud)

	# set game properties
	Game.set_hud(_hud)
	Game.set_goal_number($Goals.get_child_count())

	# init counters
	_circles_count = max_circles
	_square_count = max_squares
	_triangle_count = max_triangles
	_hud.update_counters(_circles_count, _square_count, _triangle_count)

	_select_first_active_button()


func _select_first_active_button():
	if _circles_count != 0:
		_hud.select_button(Game.CIRCLE)
	elif _square_count != 0:
		_hud.select_button(Game.SQUARE)
	elif _triangle_count != 0:
		_hud.select_button(Game.TRIANGLE)


func _unhandled_input(_event):
	if Input.is_action_just_pressed("click") && _can_cerate && !Game.is_level_accomplished:
		_can_cerate = false
		match Game.selected_shape:
			Game.CIRCLE:
				if _circles_count != 0:
					add_child(Circle.instance())
					if _circles_count != UNLIMITED:
						_circles_count -= 1
						if _circles_count == 0:
							_select_first_active_button()
						_hud.update_counters(_circles_count, null, null)
			Game.SQUARE:
				if _square_count != 0:
					add_child(Square.instance())
					if _square_count != UNLIMITED:
						_square_count -= 1
						if _square_count == 0:
							_select_first_active_button()
						_hud.update_counters(null, _square_count, null)
			Game.TRIANGLE:
				if _triangle_count != 0:
					add_child(Triangle.instance())
					if _triangle_count != UNLIMITED:
						_triangle_count -= 1
						if _triangle_count == 0:
							_select_first_active_button()
						_hud.update_counters(null, null, _triangle_count)

	elif Input.is_action_just_released("click"):
		_can_cerate = true

	elif Input.is_action_just_pressed("retry"):
		# warning-ignore:return_value_discarded
		get_tree().reload_current_scene()

	elif Input.is_action_just_pressed("ui_cancel"):
		# warning-ignore:return_value_discarded
		get_tree().change_scene("res://scenes/title.tscn")
