extends "res://Scripts/Main/Item.gd"

onready var soulNotification = get_node("../../UI/Control/PhoneUI/Soul_Notification")
onready var nearSoul = false

func _ready():
#	if(get_node("../../DialogueParser").choices["level1Soul"]):
#		queue_free()
	pass

func action(_inventory):
	get_node("../../DialogueParser").choices["soulInteracted"] = true
	pass

func _on_icon_animation_finished():
	if ($icon.animation == "Collected"):
		get_node("../../DialogueParser").choices["level1Soul"] = true
		soulNotification.play("null")
		nearSoul = false
		queue_free()


func _on_Area2D_body_entered(body):
	if(body.name == "Player"):
		soulNotification.play("default")
		nearSoul = true

func _on_Area2D_body_exited(body):
	if(body.name == "Player"):
		soulNotification.play("null")
		nearSoul = false

