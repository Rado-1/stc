tool
extends Goal


const ROTATION_MODULO = PI / 2.0


export(float, 10, 100, 10) var size setget _set_size
var _size_vector := Vector2.ZERO


func _set_size(value):
	size = value
	_size_vector.x = size
	_size_vector.y = size
	update()


func _ready():
	($CollisionShape2D.shape as RectangleShape2D).extents = _size_vector


func _draw():
	draw_rect(Rect2(-_size_vector, _size_vector * 2.0), Color(0,0,0,0.7), true)
	draw_rect(Rect2(-_size_vector, _size_vector * 2.0), Color.webgray, false, 1.0, true)


func _on_body_entered(body: Element):
	if body is Square && _is_size_matching(size, (body as Square).side_length):
		_add_matched_element(body)


func _on_body_exited(body):
	_remove_matched_element(body)


func _is_matching(element: Element):
	return _is_position_matching(position, element.position) && \
			_is_rotation_matching(rotation, element.rotation, ROTATION_MODULO)
