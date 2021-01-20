extends "res://Scripts/Main/Item.gd"
onready var dialogue = get_node("../../DialogueParser")
func _ready():
	pass
func update_choices(_choices):
	pass
func action(_inventory):
	if(get_node("../../DialogueParser").choices["level1Soul"]):
		$Sprite.animation = "open"
		$StaticBody2D/CollisionShape2D.disabled = true
		$Area2D/CollisionShape2D.disabled = true
		pass
	pass

