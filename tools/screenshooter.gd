# Utility to enable screenshoooting of all levels
extends Node


const OUT_DIR = "res://dist/levels_screenshots/"
const SCALE_X = 500
const SCALE_Y = 300


var is_active := false
var current_level: int


func start():
	is_active = true
	print("SCREENSHOOTER START")

	# prepare directory
	var output_dir = Directory.new()
	# warning-ignore:return_value_discarded
	OS.move_to_trash(ProjectSettings.globalize_path(OUT_DIR))
	# warning-ignore:return_value_discarded
	output_dir.make_dir(OUT_DIR)
	var gdignore_file = File.new()
	# warning-ignore:return_value_discarded
	gdignore_file.open(OUT_DIR + ".gdignore", File.WRITE)
	gdignore_file.close()

	# start loading levels
	current_level = 0
	open_next_level()


func open_next_level():
	current_level += 1

	var level_file = "res://levels/%03d.tscn" % current_level

	# load level
	if ResourceLoader.exists(level_file):
		# warning-ignore:return_value_discarded
		get_tree().change_scene(level_file)
	else:
		finish()


func take_screenshot():
	var output_file = OUT_DIR + "%03d.png" % current_level

	# get and save image
	yield(get_tree(), "idle_frame")
	yield(get_tree(), "idle_frame")
	var img = get_viewport().get_texture().get_data()
	img.flip_y()
	img.resize(SCALE_X, SCALE_Y, Image.INTERPOLATE_BILINEAR)
	# warning-ignore:return_value_discarded
	img.save_png(output_file)
	print(output_file)
	open_next_level()


func finish():
	print("SCREENSHOOTER FINISHED")
	get_tree().quit()
