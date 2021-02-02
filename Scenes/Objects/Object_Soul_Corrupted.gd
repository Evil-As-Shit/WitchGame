extends "res://Scripts/Main/Item.gd"

onready var notification = get_node("../../UI/Control/PhoneUI/Soul_Notification")
onready var nearSoul = false

func _ready():
	pass

func update_choices(_choices):
	pass

func action(_inventory):
	pass


func _on_icon_animation_finished():
	if ($icon.animation == "Collected"):
		get_node("../../UI/Control").ghostCount =+ 1
		get_node("../../DialogueParser").choices["level1Soul"] = true
		queue_free()

func _on_Area2D_body_entered(body):
	if(body.name == "Player"):
		notification.show()
		nearSoul = true

func _on_Area2D_body_exited(body):
	if(body.name == "Player"):
		notification.hide()
		nearSoul = false
