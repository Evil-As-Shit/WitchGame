extends "res://Scripts/Main/Item.gd"

onready var nearQR = false
onready var appName = null
export var memCost = 2
onready var qrNotification = get_node("../../UI/Control/PhoneUI/QR_Notification")

func _ready():
	pass

func update_choices(_choices):
	pass

func action(_inventory):
	pass

func _on_Area2D_body_entered(body):
	if(body.name == "Player"):
		qrNotification.play("default")
		nearQR = true

func _on_Area2D_body_exited(body):
	if(body.name == "Player"):
		qrNotification.play("null")
		nearQR = false
