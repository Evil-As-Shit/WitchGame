extends Area2D

onready var sprite = get_node("Sprite")

func _on_Area2D_body_entered(_body):
	sprite.visible = true

func _on_Area2D_body_exited(_body):
	sprite.visible = false
