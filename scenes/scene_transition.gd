extends CanvasLayer


const ANIMATION = ["fade",  "swipe_left", "scale_out", "shrink_right",
		"scale_in", "shrink_down", "scale_out_rotate", "shrink_up",
		"swipe_down", "shrink_vert", "scale_in_rotate_back", "swipe_right",
		"scale_out_rotate_back", "shrink_left", "swipe_up", "shrink_horiz",
		"scale_in_rotate"]
const ANIMATION_NUM = 17


onready var _anim = $AnimationPlayer
onready var _scr_sprite = $SpriteContainer/ScrSprite
onready var _rect = $ColorRect
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
	print(ANIMATION[_last_animation])
	_anim.play(ANIMATION[_last_animation])
	yield(_anim, "animation_finished")
	_anim.play("RESET")
	yield(_anim, "animation_finished")
	_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
	_last_animation = (_last_animation + 1 + randi() % 5) % ANIMATION_NUM


func _bake_viewport_to_sprite():
	var img = get_viewport().get_texture().get_data()
	img.flip_y()
	var scr = ImageTexture.new()
	scr.create_from_image(img)
	var scale = 1000.0 / get_viewport().size.x
	_scr_sprite.texture = scr
	_scr_sprite.scale.x = scale
	_scr_sprite.scale.y = scale
