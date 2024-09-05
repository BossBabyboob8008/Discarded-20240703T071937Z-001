extends Area2D

func _on_body_entered(body):
	if body.is_in_group("Player") and Input.is_action_pressed("E"):
		get_tree(). change_scene_to_file("res://level_2.tscn")
		
