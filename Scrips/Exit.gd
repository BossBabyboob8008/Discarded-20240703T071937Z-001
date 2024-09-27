extends Area2D

var interactable = false
@onready var label = $Label
# This hides the label by defalt
func _ready() -> void:
	label.hide()
# This code will show the label when a body enters the area2d and its in the "Player" group
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		interactable = true
		label.show()
# This code will check if the player is in the area then if E is pressed it will change the scene to the next level
func _input(event):
	if event.is_action_pressed("E") and interactable == true:
		get_tree(). change_scene_to_file("res://Levels/level_2.tscn")
# This will rehide the label when the body exits the area2d
func _on_body_exited(body: Node2D) -> void:
	label.hide()
