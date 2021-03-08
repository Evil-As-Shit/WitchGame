extends Area2D

onready var sprite = get_node("Sprite")

func _on_Area2D_body_entered(body):
	if(body.name == "Player"):
		sprite.visible = true

func _on_Area2D_body_exited(body):
	if(body.name == "Player"):
		sprite.visible = false
