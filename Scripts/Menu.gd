extends Control

onready var cat = get_node("Cat")
onready var start = get_node("TitleBox/VBoxContainer/Start")
onready var options = get_node("Options")

func _ready():
#	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
	
	
	start.grab_focus()
	pass

func _physics_process(_delta):
	if(cat.position.x > 970):
		cat.position.x -= 0.2
	else:
		cat.animation = "sitting"

func _on_Start_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/Levels/Level1.tscn")

func _on_Options_pressed():
	get_node("Options/back").grab_focus()
	options.show()
	pass # Replace with function body.

func _on_Exit_pressed():
	get_tree().quit()

func _on_back_pressed():
	get_node("TitleBox/VBoxContainer/Options").grab_focus()
	options.hide()
	pass # Replace with function body.

func _on_CheckBox_toggled(_button_pressed):
	var temp = get_node("../AudioStreamPlayer").get_playback_position()
	if (get_node("../AudioStreamPlayer").playing == true):
		get_node("../AudioStreamPlayer").stop()
	else:
		get_node("../AudioStreamPlayer").playing = true
		get_node("../AudioStreamPlayer").seek(temp)
	pass # Replace with function body.
