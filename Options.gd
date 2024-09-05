extends Control

func _on_back_pressed():
	get_tree(). change_scene_to_file("res://Levels/menu.tscn")

func _on_sound_pressed():
	get_tree(). change_scene_to_file("res://Levels/sound.tscn")
