tool
extends Node2D


func _draw():
	# draw grid
	for i in range(0, 1000, 10):
		draw_line(Vector2(i, 0), Vector2(i, 600), Color.webgray)
	for i in range(0, 600, 10):
		draw_line(Vector2(0, i), Vector2(1000, i), Color.webgray)
