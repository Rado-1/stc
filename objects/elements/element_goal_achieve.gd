class_name ElementGoalAchieve
extends Node2D


const _texture = preload("res://assets/img/goal_texture.png")


var _points: PoolVector2Array
var _uvs: PoolVector2Array


func init(points, uvs):
	_points = points
	_uvs = uvs


func _ready():
	$AnimationPlayer.play("anim")


func _draw():
	draw_colored_polygon(_points, Color.white, _uvs, _texture)
