extends Control

func _on_play_pressed():
	get_tree(). change_scene_to_file("res://Levels/level_1.tscn")

func _on_options_pressed():
	get_tree(). change_scene_to_file("res://Levels/Options.tscn")

func _on_exit_pressed():
	get_tree().quit()
