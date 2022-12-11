tool
extends Goal


const SIZE_RATIO = 2.0 / sqrt(3)
const ROTATION_MODULO = TAU / 3.0


export(float, 10, 100, 10) var size: float setget _set_size
var _height: float # 2/3 of triangle height
var _points: PoolVector2Array


func _init():
	_points.append(Vector2.ZERO)
	_points.append(Vector2.ZERO)
	_points.append(Vector2.ZERO)
	_points.append(Vector2.ZERO)


func _set_size(value: float):
	size = value
	_height = size * SIZE_RATIO
	_points[0] = Vector2(0, -_height)
	_points[1] = _points[0].rotated(ROTATION_MODULO)
	_points[2] = _points[0].rotated(-ROTATION_MODULO)
	_points[3] = _points[0]
	update()


func _ready():
	($CollisionShape2D.shape as ConvexPolygonShape2D).points = _points


func _draw():
	draw_colored_polygon(_points,  Color(0,0,0,0.7))
	draw_polyline(_points, Color.webgray, 1.0, true)
	_draw_countdown()


func _on_body_entered(body: Element):
	if body is Triangle && _is_size_matching(_height, body.size_vector_length):
		_add_matched_element(body)


func _on_body_exited(body):
	_remove_matched_element(body)


func _is_matching(element: Element):
	var x = _is_position_matching(position, element.position) && \
			_is_rotation_matching(
					rotation,
					element.rotation + element.size_vector_rotation,
					ROTATION_MODULO)
#	print(element.rotation + element.size_vector_rotation)
	return x
