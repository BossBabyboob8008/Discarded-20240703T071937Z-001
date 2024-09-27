extends Control
# Variables to keep track of the values of the sound busses.
var master_bus = AudioServer.get_bus_index("Master")
var music_bus = AudioServer.get_bus_index("Music")
var sfx_bus = AudioServer.get_bus_index("SFX")
# This code changes the volume of the bus to = the value of the slider when the slider is moved
func _on_master_value_changed(value):
	AudioServer.set_bus_volume_db(master_bus, value)
	if value == -30:
		AudioServer.set_bus_mute(master_bus, true)
	else:
		AudioServer.set_bus_mute(master_bus, false)
# This code changes the volume of the bus to = the value of the slider when the slider is moved
func _on_music_value_changed(value):
	AudioServer.set_bus_volume_db(music_bus, value)
	if value == -30:
		AudioServer.set_bus_mute(music_bus, true)
	else:
		AudioServer.set_bus_mute(music_bus, false)
# This code changes the volume of the bus to = the value of the slider when the slider is moved
func _on_sfx_value_changed(value):
	AudioServer.set_bus_volume_db(sfx_bus, value)
	if value == -30:
		AudioServer.set_bus_mute(sfx_bus, true)
	else:
		AudioServer.set_bus_mute(sfx_bus, false)
# This tracks if the button is pressed and changes the sence to which button you click.
func _on_back_pressed():
	get_tree(). change_scene_to_file("res://Levels/Options.tscn")
