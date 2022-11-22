# Abstract element class.
class_name Element
extends RigidBody2D


const _texture = preload("res://assets/img/goal_texture.png")
const DENSITY = 0.01
const MIN_MASS = 0.01
const UVS_RATIO = 200.0


onready var _collision_shape = $CollisionShape
var _is_being_edited := true
var _is_matched := false
var size_vector: Vector2
var size_vector_length: float
var size_vector_rotation: float
var _points: PoolVector2Array
var _uvs: PoolVector2Array


func _ready():
	Audio.element_new()
	position = get_viewport().get_mouse_position()
	z_index = 15
#	can_sleep = false


func _process(_delta):
	if _is_being_edited:
		size_vector = get_viewport().get_mouse_position() - position
		size_vector = size_vector.limit_length(_max_size())
		size_vector_length = size_vector.length()
		if size_vector_length < _min_size():
			size_vector = \
					size_vector * (_min_size() / size_vector_length) \
					if size_vector_length != 0.0 \
					else _min_vector()
			size_vector_length = _min_size()
		size_vector_rotation = size_vector.angle()

		_editing_update()
		update()


#func _physics_process(_delta):
#	modulate = Color.webgray if sleeping else Color.white


func _unhandled_input(_event):
	if _is_being_edited && Input.is_action_just_released("click"):
		_is_being_edited = false
		set_process(false)
		mode = RigidBody2D.MODE_RIGID
		var m = log(_get_mass()) # to eliminate too weighty objedts
		mass = m if m > 0.0 else MIN_MASS
		Audio.element_done()


func make_matched():
	mode = RigidBody2D.MODE_STATIC
	_is_matched = true
	_compute_points()
	_compute_uvs()
	update()


func _compute_uvs():
	var pp
	for p in _points:
		pp = (position + (p as Vector2).rotated(rotation))/ UVS_RATIO
		_uvs.push_back(pp)


# callbacks implemented in subclasses
func _min_vector() -> Vector2: return Vector2(10.0,0.0)
func _min_size() -> float: return 10.0
func _max_size() -> float: return 100.0
func _editing_update(): pass
func _get_mass() -> float: return MIN_MASS
func _compute_points(): pass
