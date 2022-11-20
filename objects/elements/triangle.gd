class_name Triangle
extends Element


const ROTATION_ANGLE = TAU / 3.0
const ROTATION_CORRECTION = PI / -6.0
const MASS_CONSTANT = sqrt(3.0) * 0.75


func _ready():
	_points = ($CollisionShape.shape as ConvexPolygonShape2D).points


func _min_vector() -> Vector2:
	return Vector2(10.0,5.773502692)


func _min_size():
	return 11.547005384


func _max_size():
	return 115.47005384


func _editing_update():
	_points[0] = size_vector
	_points[1] = size_vector.rotated(ROTATION_ANGLE)
	_points[2] = size_vector.rotated(-ROTATION_ANGLE)
	($CollisionShape.shape as ConvexPolygonShape2D).points = _points


func _get_mass():
	size_vector_rotation += ROTATION_CORRECTION
	return size_vector_length * size_vector_length * MASS_CONSTANT * DENSITY


func _draw():
	if _is_matched:
		draw_colored_polygon(_points, Color.white, _uvs, _texture)
	else:
		draw_colored_polygon(_points, Color.lightgreen)
