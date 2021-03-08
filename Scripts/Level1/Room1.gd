extends Node

onready var player=get_node("../Player")

func _on_Area2D_body_entered(body):
	if(body.name == "Player"):
		var QRCode = get_node("../QRCode_Room1")
		QRCode.appName = "decrypt"
		player.location = "Room1"
