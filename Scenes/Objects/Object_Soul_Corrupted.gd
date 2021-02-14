extends "res://Scripts/Main/Item.gd"

onready var soulNotification = get_node("../../UI/Control/PhoneUI/Soul_Notification")
onready var nearSoulCorrupt = false
onready var inBattle = get_node("../../UI/Control").battlemode

func _ready():
	pass

func update_choices(_choices):
	pass

#func _physics_process(delta):


func action(_inventory):
	pass

func _on_icon_animation_finished():
	if ($icon.animation == "Collected"):
		get_node("../../UI/Control").ghostCount =+ 1
		get_node("../../DialogueParser").choices["level1Soul"] = true
		queue_free()

func _on_Area2D_body_entered(body):
	if(body.name == "Player"):
		nearSoulCorrupt = true
		soulNotification.show()


func _on_Area2D_body_exited(body):
	if(body.name == "Player"):
		nearSoulCorrupt = false
		soulNotification.hide()

