tool
extends Node2D


const BEAM_ANGLE = TAU / 48.0
const BEAM_2_DELTA = TAU / 96.0


func _draw():
	# draw circles
	for i in range(0, 310, 10):
		draw_arc(Vector2.ZERO, i + 0.5, 0, TAU, 48, Color.webgray)

	# draw beams
	for i in range(0, 48):
		draw_line(
				Vector2(25.0, 0.0).rotated(i * BEAM_ANGLE),
				Vector2(310.0, 0.0).rotated(i * BEAM_ANGLE), Color.webgray)

	# draw beams level 2
	for i in range(0, 48):
		draw_line(
				Vector2(205.0, 0.0).rotated(BEAM_2_DELTA + i * BEAM_ANGLE),
				Vector2(310.0, 0.0).rotated(BEAM_2_DELTA + i * BEAM_ANGLE), Color.webgray)
