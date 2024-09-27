extends Area2D
# This code allows the player to die by checking if 
# the player is in the 2D area and if that is ture 
# than it will restart the current sence
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		get_tree().reload_current_scene()
