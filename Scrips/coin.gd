extends Area2D
# will add to the score counter (the score counter being a globle variable) when a coin is collected
func collected():
	Gamemanager.score += 1
	
# This code checks if the player is in the area2d by checking if 
# the object is in the "Player" group it will then say the coin is collected
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		collected()
		queue_free()
