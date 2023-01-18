extends Node

var panelNode
var isDialogueEvent = false
var myStory = {}
var initStory
var currDialogue
var currChoices = []
var isChoice = false
var isChoiceDialogue = false
var isEnd = false
var events = {}
var choices = {}
var texting = false
var endOfLine = false
var texttween = Tween.new()
onready var audio = get_node("../UI/Control/NinePatchRect/AudioStreamPlayer")
onready var blip = load("res://Assets/sfx/blip.wav")
onready var player = get_node("../YSort/Player")
onready var ui = get_node("../UI/Control")

func _ready():
	set_process_input(true)
	myStory = load_file_as_JSON("res://Narrative/Level1/Test.json")
	events = load_file_as_JSON("res://Narrative/Level1/events.json")
	choices = load_file_as_JSON("res://Narrative/Level1/choices.json")
	panelNode = get_node("../UI/Control/NinePatchRect")
	if(panelNode.is_visible()):
		panelNode.hide()
		player.interacting = false
	texttween.connect("tween_step",self,"On_Tween_Step")
	texttween.connect("tween_completed",self,"Tween_Completed")
	panelNode.get_node("Label").add_child(texttween)
#	panelNode.get_node("nullLabel").add_child(texttween)
#func lock_next_button(isHidden):
#	if(isHidden):
#		panelNode.get_node("Button").hide()
#		pass
#	if(isHidden == false):
#		panelNode.get_node("Button").show()
#		pass

#func isInChoiceMode():
#	return panelNode.get_node("Button").is_hidden()

func get_choices():
	currChoices = []
	for item in currDialogue:
#		print(item)
		if(typeof(item) != TYPE_STRING and item.has("linkPath")):
			currChoices.append(item)
#	lock_next_button(true)

func look_up_event(target):
	return events["eventTarget"][target]

func choose_dialogue(possibilities, choice):
	for item in possibilities:
		if(item != "Start" and item != "Repeat"):
			if(choice[possibilities[item]["Flag"]]):
				return possibilities[item]["Name"]
	return null

func load_file_as_JSON(path):
	var file = File.new()
	file.open(path, file.READ)
	var content = file.get_as_text()
	var target = parse_json(content)
	file.close()
	return target

func choose_dialogue_branch(target):
	var possibleBranches = look_up_event(target)
	var branch = choose_dialogue(possibleBranches, choices)

	if(branch != null):
#		print(branch)
		return branch
	elif(!possibleBranches["Start"]["Flag"]):
		possibleBranches["Start"]["Flag"] = true
		return possibleBranches["Start"]["Name"]
	elif("Repeat" in possibleBranches):
		possibleBranches["Repeat"]["Flag"] = true
		return possibleBranches["Repeat"]["Name"]
	else:
		possibleBranches["Start"]["Flag"] = true
		return possibleBranches["Start"]["Name"]

func display_choices(_text):
	if(isChoice and !isChoiceDialogue):
		player.choosing = true
		var path = "res://Assets/ui/Fonts/Boo City.ttf"
		var new_font = DynamicFont.new()
		var new_data = DynamicFontData.new()
		new_data.font_path = path
		new_font.size = 20
		new_font.font_data = new_data
		for i in range(0, currChoices.size()):
			var choiceButton = Button.new()
			choiceButton.set_name("ChoiceButton" + str(i))
			panelNode.add_child(choiceButton)
			choiceButton.set_position(Vector2(100 + 75*i, 55))
			choiceButton.set_size(Vector2(55,35))
			choiceButton.flat = true
			choiceButton.connect("pressed", self, "_on_button_pressed", [choiceButton])
			choiceButton.set("custom_colors/font_color_focus",Color(1,1,0,1))
			choiceButton.text = (currChoices[i]["option"])
			choiceButton.set("custom_styles/focus",StyleBoxEmpty.new())
			choiceButton.set("custom_fonts/font", new_font)
#			var choiceLabel = Label.new()
#			choiceLabel.set_name("ChoiceLabel" + str(i))
#			panelNode.get_node("ChoiceButton" + str(i)).add_child(choiceLabel)
#			choiceLabel.set_position(Vector2(10,10))
#			choiceLabel.set_size(Vector2(50, 50))
#			choiceLabel.set_autowrap(true)
##			choiceLabel.set_text(currChoices[i]["option"])
#			choiceLabel.set("custom_fonts/font", new_font)
		for i in range(0, currChoices.size()):
			var Button = panelNode.get_node("ChoiceButton" + str(i))
			Button.set_focus_neighbour(MARGIN_BOTTOM, Button.get_path())
			Button.set_focus_neighbour(MARGIN_TOP, Button.get_path())
			if(i == 0):
#				print("1")
				Button.grab_focus()
				Button.set_focus_neighbour(MARGIN_LEFT, Button.get_path())
				Button.set_focus_neighbour(MARGIN_RIGHT, panelNode.get_node("ChoiceButton" + str(i+1)).get_path())
			elif(i < currChoices.size() and i != currChoices.size()):
#				print("2", i, currChoices.size())
				Button.set_focus_neighbour(MARGIN_LEFT, panelNode.get_node("ChoiceButton" + str(i-1)).get_path())
				if(panelNode.has_node("ChoiceButton" + str(i+1))):
					Button.set_focus_neighbour(MARGIN_RIGHT, panelNode.get_node("ChoiceButton" + str(i+1)).get_path())
			elif(i == currChoices.size()):
#				print("3")
				Button.set_focus_neighbour(MARGIN_LEFT, panelNode.get_node("ChoiceButton" + str(i-1)).get_path())
				Button.set_focus_neighbour(MARGIN_RIGHT, Button.get_path())

func clear_choices(shouldClear):
	player.choosing = false
#	lock_next_button(false)
#	if(panelNode.get_child_count() > 2):
	for i in range(0, currChoices.size()):
		var button = panelNode.get_node("ChoiceButton" + str(i))
#		print(button)
		if(button != null):
			if(shouldClear):
#				print("clearing button", button.name)
				button.queue_free()
			else:
				button.hide()
		else:
			break

func set_choice_values():
	var newLinkType = get_link_type(currDialogue[2])
#	print(newLinkType, isChoiceDialogue)
	if(newLinkType == "divert"):
		isChoice = false
		isChoiceDialogue = false
	if(newLinkType == "linkPath" and isChoiceDialogue):
		isChoice = true
		isChoiceDialogue = false
#		print(isChoiceDialogue)
	elif(newLinkType == "linkPath" and !isChoiceDialogue):
		isChoice = true
		isChoiceDialogue = true

func set_next_dialogue(target):
#	print("dialogue target=", target.name)
	if !("isEnd" in currDialogue[2]):
		var linkType = get_link_type(currDialogue[2])
#		print("linkType: ", linkType)
		if(linkType == "divert"):
			currDialogue = initStory[currDialogue[2]["divert"]]["content"]
		elif(linkType == "linkPath" and isChoiceDialogue):
#			print("getting choices...")
			get_choices()
		elif(linkType == "linkPath" and !isChoiceDialogue):
#			print("here")
			currDialogue = initStory[currDialogue[get_user_choice(target) + 2]["linkPath"]]["content"]
		set_choice_values()
	else:
		isEnd = true
		player.canMove = true
		panelNode.hide()
		player.interacting = false

func get_user_choice(target):
	var buttonName = target.get_name()
	var id = buttonName.to_int()
	return id

func get_link_type(dialogue):
	var linkType
	if dialogue.has("divert"):
		linkType = "divert"
	elif dialogue.has("linkPath"):
		linkType = "linkPath"
	elif dialogue.has("isEnd"):
		linkType = "divert"
	return linkType

func _on_button_pressed(target):
#	print(target)
	if(isEnd):
		panelNode.hide()
		player.interacting = false
	var textToShow = ""
	panelNode.get_node("expressions").play("null")
#	print("choice clear:", !(isChoice and !isChoiceDialogue))
	clear_choices(!(isChoice and !isChoiceDialogue))
	set_next_dialogue(target)
	if (isChoice and !isChoiceDialogue):
#		print("am here")
		display_choices(textToShow)
	else:
#		print("does this happen?")
		textToShow = currDialogue[0]
		panelNode.get_node("expressions").play(currDialogue[1]["expression"])
		show_text(textToShow, target)

func On_Tween_Step(object,key,_elapsed,_value):
	if(!player.interupt):
		if(texting):
			audio.stream = blip
			audio.play()
#	elif(object.get_text() == "Charging phone..."):
#		var audio = panelNode.get_node("AudioStreamPlayer")
#		audio.stream = load("res://Assets/sfx/blip.wav")
#		audio.play()
	else:
#		texttween.remove_all()
		texttween.emit_signal("tween_completed",object,key)
#		texttween.reset_all()
#		print("tweens_stopped")
		Tween_Completed(object,key)
		player.interupt = false
		if (!currDialogue[1]["expression"] == "null"):
			panelNode.get_node("Label").set_percent_visible(1)
		else:
			panelNode.get_node("nullLabel").set_percent_visible(1)

func Tween_Completed(object,_key):
#	print("tween completed")
#	print(object.get_text())
	texttween.remove_all()
	if(object.get_text() == "Charging phone..." and ui.batteryLife != 10):
		ui.chargeBattery()
	else:
		texting = false

func show_text(text, target):
	if(panelNode.is_visible()):
		print(text)
		print(ui.batteryLife)
		if(text == "Charging phone..."):
			if(ui.batteryLife == 10):
				text = "Phone is already charged!"
			else:
				get_tree().get_root().set_disable_input(true)
		var length = text.length()
		var t = 0.025
		var time = length * t
		panelNode.get_node("Label").set_text(text)
		panelNode.get_node("nullLabel").set_text(text)
		texting = true
		panelNode.get_node("Label").set_percent_visible(0)
		panelNode.get_node("nullLabel").set_percent_visible(0)
		if(!player.interupt):
			if (!currDialogue[1]["expression"] == "null"):
				panelNode.get_node("nullLabel").set_text("")
				texttween.interpolate_property(panelNode.get_node("Label"),"percent_visible",0,1,time,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
				texttween.start()
			else:
				panelNode.get_node("Label").set_text("")
				texttween.interpolate_property(panelNode.get_node("nullLabel"),"percent_visible",0,1,time,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
				texttween.start()
		yield(texttween,"tween_completed")
#		var t = Timer.new()
#		t.set_wait_time(0.025)
#		t.set_one_shot(true)
#		self.add_child(t)
#		var i = 0
#		var audio = panelNode.get_node("AudioStreamPlayer")
#		texting = true
#		for letter in text:
#			if (!player.interupt):
#				i += 1
#				var newText = text.substr(0,i)
#				t.start()
#				if (!currDialogue[1]["expression"] == "null"):
#					panelNode.get_node("nullLabel").set_text("")
#					panelNode.get_node("Label").set_text(newText)
#				else:
#					panelNode.get_node("Label").set_text("")
#					panelNode.get_node("nullLabel").set_text(newText)
#				audio.play()
#				yield(t,"timeout")
#			else:
#				if (!currDialogue[1]["expression"] == "null"):
#					panelNode.get_node("nullLabel").set_text("")
#					panelNode.get_node("Label").set_text(text)
#				else:
#					panelNode.get_node("Label").set_text("")
#					panelNode.get_node("nullLabel").set_text(text)
#				audio.play()
#				player.interupt = false
#				break
		if(isChoice and isChoiceDialogue):
			_on_button_pressed(target)

func init_dialogue(target):
#	print(choices)
	endOfLine = false
	isDialogueEvent = false
	initStory = null
	currDialogue = null
	currChoices = []
	isChoice = false
	isChoiceDialogue = false
	isEnd = false
#	var player = get_node("../YSort/Player")
	player.animationState.travel("Idle")
	get_node("../YSort/" + target).update_choices(choices)
	target = choose_dialogue_branch(target)
	
	panelNode.show()
	
	initStory = myStory["data"][target]
	currDialogue = initStory[initStory["initial"]]["content"]
#	print(currDialogue[1]["expression"])
	if (currDialogue[1]["expression"] == "null"):
		if currDialogue[2].has("divert"):
			isChoice = false
			isChoiceDialogue = false
		if currDialogue[2].has("linkPath"):
			isChoice = true
			isChoiceDialogue = true
	show_text(currDialogue[0], target)
	panelNode.get_node("expressions").play(currDialogue[1]["expression"])
