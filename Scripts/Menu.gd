extends Control

onready var start = get_node("VBoxContainer/Start")

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	start.grab_focus()
	pass
func _on_Start_pressed()->void:
	get_tree().change_scene("res://Scenes/Levels/Level1.tscn")
func _on_Exit_pressed():
	get_tree().quit()
