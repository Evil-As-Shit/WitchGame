extends Sprite

onready var player=get_node("../Player")

func _on_Area2D_body_entered(body):
	if(body.name == "Player"):
		self.z_index = 0

func _on_Area2D_body_exited(body):
	if(body.name == "Player"):
		self.z_index = 1
