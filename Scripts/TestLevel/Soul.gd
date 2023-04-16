class_name Soul
extends "res://Scripts/Main/Item.gd"

export var is_corrupted: bool = false

func _ready():
	GameData.dict_soul_is_corrupted[self.name] = is_corrupted
#	if(get_node("../../DialogueParser").choices["level1Soul"]):
#		queue_free()
	pass

func action(_inventory):
	get_node("../../DialogueParser").choices["soulInteracted"] = true
	pass

func collect():
	GameData.commands.append(PlayAnimationCommand.new($icon, "Collected", true))

func _on_icon_animation_finished():
	if ($icon.animation == "Collected"):
		get_node("../../DialogueParser").choices["level1Soul"] = true
		SignalController.emit_signal("entered_soul", false)
		queue_free()


func _on_Area2D_body_entered(body):
	if(body.name == "Player"):
		SignalController.emit_signal("entered_soul", true)
		GameData.nearestSoul = self

func _on_Area2D_body_exited(body):
	if(body.name == "Player"):
		SignalController.emit_signal("entered_soul", false)
		if (GameData.nearestSoul == self):
			GameData.nearestSoul = null
