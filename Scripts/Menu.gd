extends Control

onready var cat = get_node("Cat")
onready var start = get_node("VBoxContainer/Start")

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	start.grab_focus()
	pass

func _physics_process(delta):
	if(cat.position.x > 970):
		cat.position.x -= 0.2
	else:
		cat.animation = "sitting"

func _on_Start_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/Levels/Level1.tscn")
func _on_Exit_pressed():
	get_tree().quit()
