extends Area2D

func collected():
	Gamemanager.score += 1
	

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		collected()
		queue_free()
