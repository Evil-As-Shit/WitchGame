extends "res://Scripts/Main/Item.gd"

onready var nearSoulCorrupt = false
onready var inBattle = get_node("../../UI/Control").battlemode

func _ready():
	pass

func update_choices(_choices):
	pass

#func _physics_process(delta):


func action(_inventory):
	pass

func _on_Area2D_body_entered(body):
	if(body.name == "Player"):
		nearSoulCorrupt = true
		SignalController.emit_signal("entered_soul", true)

func _on_Area2D_body_exited(body):
	if(body.name == "Player"):
		nearSoulCorrupt = false
		SignalController.emit_signal("entered_soul", false)

