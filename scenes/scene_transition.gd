extends CanvasLayer


const MASK_BOTTOM_TO_TOP = preload("res://assets/img/transition_masks/bottom_to_top.svg")
const MASK_CENTER_FROM = preload("res://assets/img/transition_masks/center_from.svg")
const MASK_CENTER_TO = preload("res://assets/img/transition_masks/center_to.svg")
const MASK_DIAG_BOTTOM_LEFT = preload("res://assets/img/transition_masks/diag_bottom_left.svg")
const MASK_DIAG_BOTTOM_RIGHT = preload("res://assets/img/transition_masks/diag_bottom_right.svg")
const MASK_DIAG_TOP_LEFT = preload("res://assets/img/transition_masks/diag_top_left.svg")
const MASK_DIAG_TOP_RIGHT = preload("res://assets/img/transition_masks/diag_top_right.svg")
const MASK_DOTS = preload("res://assets/img/transition_masks/dots.svg")
const MASK_HOLES = preload("res://assets/img/transition_masks/holes.svg")
const MASK_LEFT_TO_RIGHT = preload("res://assets/img/transition_masks/left_to_right.svg")
const MASK_RIGHT_TO_LEFT = preload("res://assets/img/transition_masks/right_to_left.svg")
const MASK_SNAKE_HORIZ = preload("res://assets/img/transition_masks/snake_horiz.svg")
const MASK_SNAKE_SPIRAL = preload("res://assets/img/transition_masks/snake_spiral.svg")
const MASK_SNAKE_VERT = preload("res://assets/img/transition_masks/snake_vert.svg")
const MASK_SPIRAL = preload("res://assets/img/transition_masks/spiral.svg")
const MASK_SQUARES = preload("res://assets/img/transition_masks/squares.svg")
const MASK_STRIPES_HORIZ = preload("res://assets/img/transition_masks/stripes_horiz.svg")
const MASK_STRIPES_VERT = preload("res://assets/img/transition_masks/stripes_vert.svg")
const MASK_TOP_TO_BOTTOM = preload("res://assets/img/transition_masks/top_to_bottom.svg")


const MASKS = [MASK_RIGHT_TO_LEFT, MASK_HOLES, MASK_SNAKE_HORIZ, MASK_CENTER_TO,
		MASK_DIAG_BOTTOM_RIGHT, MASK_STRIPES_HORIZ, MASK_DIAG_TOP_LEFT, MASK_SNAKE_SPIRAL,
		MASK_TOP_TO_BOTTOM, MASK_DOTS, MASK_DIAG_TOP_RIGHT, MASK_CENTER_FROM,
		MASK_LEFT_TO_RIGHT, MASK_STRIPES_VERT, MASK_SQUARES, MASK_DIAG_BOTTOM_LEFT,
		MASK_SNAKE_VERT, MASK_BOTTOM_TO_TOP, MASK_SPIRAL]
const MASKS_COUNT = 19


onready var _anim_player = $AnimationPlayer
onready var _rect = $TextureRect
var _last_animation := 3


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
	(_rect.material as ShaderMaterial).set_shader_param(
			"mask", MASKS[_last_animation])
	_rect.visible = true
	_anim_player.play("transition")
	yield(_anim_player, "animation_finished")
	_rect.visible = false
	_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
	_last_animation = (_last_animation + 1 + randi() % 2) % MASKS_COUNT


func _bake_viewport_to_sprite():
	var img = get_viewport().get_texture().get_data()
	img.flip_y()
	var scr = ImageTexture.new()
	scr.create_from_image(img)
	_rect.texture = scr
