class_name GoalCountdown
extends Node2D


func set_progress(value: float):
	$Meter.angle_degrees = value * 360.0
