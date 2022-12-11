class_name Square
extends Element


const SCALE_RATIO = 1.0 / sqrt(2)
const ROTATION_CORRECTION = PI / 4.0


var side_length: float
var _side_length_vector := Vector2.ZERO


func _min_vector() -> Vector2:
	return Vector2(10.0,10.0)


func _min_size():
	return 14.1421356237


func _max_size():
	return 141.421356237


func _editing_update():
	side_length = size_vector_length * SCALE_RATIO
	_side_length_vector.x = side_length
	_side_length_vector.y = side_length
	(_collision_shape.shape as RectangleShape2D).extents = _side_length_vector
	rotation = size_vector_rotation - ROTATION_CORRECTION


func _get_mass():
	return side_length * side_length * 4.0 * DENSITY


func _compute_points():
	_points = PoolVector2Array()
	_points.append(_side_length_vector)
	_points.append(_side_length_vector * Vector2(1.0, -1.0))
	_points.append(_side_length_vector * -1.0)
	_points.append(_side_length_vector * Vector2(-1.0, 1.0))


func _draw():
	if _is_matched:
		draw_colored_polygon(_points, Color.white, _uvs, _texture)
	else:
		draw_rect(Rect2(-_side_length_vector, _side_length_vector * 2.0),
				Color.webgray if _is_matched else Color.deepskyblue, true)
