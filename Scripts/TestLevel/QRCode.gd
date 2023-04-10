extends "res://Scripts/Main/Item.gd"

onready var nearQR = false
onready var appName = null
export var memCost = 2

func _ready():
	pass

func update_choices(_choices):
	pass

func action(_inventory):
	pass

func _on_Area2D_body_entered(body):
	if(body.name == "Player" && nearQR == false):
		SignalController.emit_signal("entered_qr", true)
		nearQR = true

func _on_Area2D_body_exited(body):
	if(body.name == "Player" && nearQR == true):
		SignalController.emit_signal("entered_qr", false)
		nearQR = false
