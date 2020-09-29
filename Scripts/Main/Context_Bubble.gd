extends Area2D

onready var sprite = get_node("Sprite")

func _on_Area2D_body_entered(body):
	sprite.visible = true

func _on_Area2D_body_exited(body):
	sprite.visible = false
