extends Sprite
var myInventory = []
onready var slot_1 = get_node("slot_1")
onready var slot_2 = get_node("slot_2")
onready var slot_3 = get_node("slot_3")

func _ready():
	myInventory = load_file_as_JSON("res://Narrative/Level1/inventory.json")
	print(myInventory)
	update_inventory(myInventory)


func load_file_as_JSON(path):
	var file = File.new()
	file.open(path, file.READ)
	var content = file.get_as_text()
	var target = parse_json(content)
	file.close()
	return target


func update_inventory(inventory):
	slot_1.set_texture(load("res://Assets/ui/"+inventory["items"][0]+"icon.png"))
	slot_2.set_texture(load("res://Assets/ui/"+inventory["items"][1]+"icon.png"))
	slot_3.set_texture(load("res://Assets/ui/"+inventory["items"][2]+"icon.png"))
