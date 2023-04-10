extends "res://Scripts/Main/Item.gd"

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
		SignalController.emit_signal("entered_soul", false)
		nearSoul = false
		queue_free()


func _on_Area2D_body_entered(body):
	if(body.name == "Player" && nearSoul == false):
		SignalController.emit_signal("entered_soul", true)
		nearSoul = true

func _on_Area2D_body_exited(body):
	if(body.name == "Player" && nearSoul == true):
		SignalController.emit_signal("entered_soul", false)
		nearSoul = false

