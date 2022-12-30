class_name Circle
extends Element


const POINTS_COUNT = 20
const POINTS_ANGLE_DELTA = TAU / POINTS_COUNT


func _editing_update():
	(_collision_shape.shape as CircleShape2D).radius = size_vector_length


func _get_mass() -> float:
	return PI * size_vector_length * size_vector_length * DENSITY


func _compute_points():
	_points = PoolVector2Array()

	for i in range(POINTS_COUNT):
		_points.append(Vector2(size_vector_length, 0).rotated(i * POINTS_ANGLE_DELTA))


func _draw():
	if _is_matched:
		draw_colored_polygon(_points, Color.white, _uvs, _texture)
	else:
		draw_circle(Vector2.ZERO, size_vector_length,
				Color.webgray if _is_matched else Color(0.9, 0.2, 0.2, 1))
