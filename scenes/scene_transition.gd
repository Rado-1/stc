extends CanvasLayer


const ANIMATION = ["fade", "left_to_right", "holes", "center_to",
		"bottom_to_top", "stripes_horiz", "diag_top_left", "dots",
		"right_to_left", "diag_bottom_left", "center_from", "top_to_bottom",
		"stripes_vert", "diag_bottom_left", "squares", "diag_bottom_right",
		"spiral"]
const ANIMATION_NUM = 17


onready var _anim_player = $AnimationPlayer
onready var _rect = $TextureRect
var _last_animation := 0


func change_scene(target: String):
	_rect.mouse_filter = Control.MOUSE_FILTER_STOP
	_bake_viewport_to_sprite()
	# warning-ignore:return_value_discarded
	get_tree().change_scene(target)
	_animate()


func reload_current_scene():
	_rect.mouse_filter = Control.MOUSE_FILTER_STOP
	_bake_viewport_to_sprite()
	# warning-ignore:return_value_discarded
	get_tree().reload_current_scene()
	_animate()


func _animate():
	#print(ANIMATION[_last_animation])
	_rect.visible = true
	_anim_player.play(ANIMATION[_last_animation])
	yield(_anim_player, "animation_finished")
	_rect.visible = false
	(_rect.material as ShaderMaterial).set_shader_param("smooth_size", 0.05)
	_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
	_last_animation = (_last_animation + 1 + randi() % 2) % ANIMATION_NUM


func _bake_viewport_to_sprite():
	var img = get_viewport().get_texture().get_data()
	img.flip_y()
	var scr = ImageTexture.new()
	scr.create_from_image(img)
	_rect.texture = scr
