tool
extends Goal


export(float, 10, 100, 10) var radius setget _set_radius


func _set_radius(value):
	radius = value
	update()


func _ready():
	($CollisionShape2D.shape as CircleShape2D).radius = radius


func _draw():
	draw_circle(Vector2.ZERO, radius, Color(0,0,0,0.7))
	draw_arc(Vector2.ZERO, radius, 0, TAU, 20 + radius / 3, Color.webgray, 1.0, true)
	_draw_countdown()


func _on_body_entered(body: Element):
	if body is Circle && _is_size_matching(radius, body.size_vector_length):
		_add_matched_element(body)


func _on_body_exited(body):
	_remove_matched_element(body)


func _is_matching(element: Element):
	return _is_position_matching(position, element.position)
