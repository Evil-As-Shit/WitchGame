extends StaticBody2D

onready var player=get_node("../Player")

func _on_Area2D_body_entered(body):
	if(body.name == "Player"):
		player.location = "Room1"
		var QRCode = get_node("../QRCode_"+player.location)
		QRCode.appName = "RemoteApp"


#func _on_Area2D_body_exited(body):
#	if(body.name == "Player"):
#		self.z_index = 1
