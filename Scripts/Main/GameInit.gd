extends Node

func _ready():
	var player = get_node("YSort/Player")
	var interactables = get_tree().get_nodes_in_group("Interactable")
	for i in range(interactables.size()):
		var currNode = get_node(interactables[i].get_path())
		var area2DNode = currNode.get_node("Area2D")
		var args = Array([currNode])
		area2DNode.connect("body_entered", player,"_on_Area2D_body_enter", args)
		area2DNode.connect("body_exited", player, "_on_Area2D_body_exit", args)
