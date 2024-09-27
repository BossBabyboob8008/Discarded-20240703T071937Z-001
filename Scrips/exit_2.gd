extends Area2D

var interactable = false
@onready var label = $Label

func _ready() -> void:
	label.hide()
# This code will display a label above the Object 
# if the player is inside of the area of interaction
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		interactable = true
		label.show()
# This code will check if the player is in the area then if E is pressed it will change the scene to the next level
func _input(event):
	if event.is_action_pressed("E") and interactable == true:
		get_tree(). change_scene_to_file("res://Levels/level_3.tscn")

func _on_body_exited(body: Node2D) -> void:
	label.hide()
