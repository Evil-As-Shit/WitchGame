extends Control

var inUI = false
var ghostCount = 0
var battlemode = false
var texting = false
var interupt = false
var text1seen = false
var qrText = ""
var inApp = false
var focusedApp = ""
var choosing = false
var focused = null
onready var player = get_node("../../YSort/Player")
onready var soul = get_node("../../YSort/Object_Soul")
onready var soulCorrupt = get_node("../../YSort/Object_Soul_Corrupted")
onready var phone = get_node("PhoneUI")
onready var appscreen = get_node("PhoneUI/AppScreen")
onready var soul_notification = get_node("PhoneUI/Soul_Notification")
onready var soul_collected = get_node("PhoneUI/Soul_Collected")
onready var audio = get_node("../../AudioStreamPlayer")
onready var time = get_node("PhoneUI/Time")
onready var memory = get_node("PhoneUI/Memory")
onready var options = get_node("PhoneUI/Options")
onready var app1 = get_node("PhoneUI/App1")
onready var app2 = get_node("PhoneUI/App2")
onready var app3 = get_node("PhoneUI/App3")
onready var app4 = get_node("PhoneUI/App4")
onready var app5 = get_node("PhoneUI/App5")
onready var app6 = get_node("PhoneUI/App6")
onready var app7 = get_node("PhoneUI/App7")
onready var app8 = get_node("PhoneUI/App8")
onready var QRApp = get_node("PhoneUI/QRApp")
onready var textapp = get_node("PhoneUI/TextApp")
onready var pixapp = get_node("PhoneUI/PixApp")
onready var soulapp = get_node("PhoneUI/SoulApp")
onready var battApp1 = get_node("PhoneUI/BattleApp1")
onready var battApp2 = get_node("PhoneUI/BattleApp2")
onready var battApp3 = get_node("PhoneUI/BattleApp3")
onready var battApp4 = get_node("PhoneUI/BattleApp4")
onready var QRCode = get_node("../../YSort/QRCode")
onready var battleApps = []
onready var phoneLabel = get_node("PhoneUI/AppScreen/Label")
signal button_pressed
enum State{
	state_text1
	state_text2,
	state_appinstalled
	}

func _ready():
	pass

func _physics_process(delta):
	if (inUI):
		phone.position = phone.position.linear_interpolate(Vector2(200,430), delta*10) 
	if (!inUI):
		phone.position = phone.position.linear_interpolate(Vector2(200,900), delta*10) 
	var osTime = OS.get_time()
	var hour = String(osTime.hour)
	var minute = String(osTime.minute)
	var currentTime = hour + ":" + minute
	time.set_text(currentTime)
	memory.set_text(str(ghostCount))

#pressing e when in phone ui
func _input(_event):
	if(Input.is_action_just_pressed("e") and inUI):
		if(!inApp):
			focused = get_focus_owner()
			print(focused.name)
		if(texting):
			interupt = true
			get_tree().set_input_as_handled()
#pressing e on soul app
		elif(focused.name == "SoulApp"):
			if(soul != null):
				if(soul.nearSoul):
					get_node("../../YSort/Object_Soul/icon").animation = "Collected"
					soul_collected.animation = "collected"
					audio.stream = load("res://Assets/sfx/find ghost v2.wav")
					audio.play()
					player.interacting = true
					get_tree().get_root().set_disable_input(true)
					yield(audio, "finished")
					player.interacting = false
					get_tree().get_root().set_disable_input(false)
			if(soulCorrupt != null):
				if(soulCorrupt.nearSoulCorrupt):
					if(battlemode):
						focusedApp = get_focus_owner().name
						if(focusedApp == "BattleApp1"):
							print("BattleApp1 GOOO!!")
						if(focusedApp == "BattleApp2"):
							print("BattleApp2 GOOO!!")
						if(focusedApp == "BattleApp3"):
							print("BattleApp3 GOOO!!")
						if(focusedApp == "BattleApp4"):
							print("BattleApp4 GOOO!!")
					if(!inApp):
						enterApp()
						battApp1.show()
						battApp2.show()
						battApp3.show()
						battApp4.show()
						soul_notification.hide()
						phone.play("battle")
						battlemode = true
						battApp1.grab_focus()
#pressing e on QRApp
		elif(focused.name == "QRApp" and QRCode.nearQR):
			if(!inApp):
				enterApp()
			if(battleApps.has(QRCode.appName)):
				qrText = "This app is already installed"
				yield(appscreen,"animation_finished")
				show_text(qrText)
				phone.get_node("HomeButton").grab_focus()
				get_tree().set_input_as_handled()
			elif(choosing):
				if(text1seen):
					qrText = "Download App?"
					show_text(qrText)
					appscreen.get_node("Button").show()
					appscreen.get_node("Button2").show()
					appscreen.get_node("Button").grab_focus()
					choosing = false
					get_tree().set_input_as_handled()
			elif(!text1seen):
				print("first text")
				qrText = "A sketchy app is available to download from the undernet!"
				yield(appscreen,"animation_finished")
				show_text(qrText)
				text1seen = true
				choosing = true
				get_tree().set_input_as_handled()
			else:
				print("passed1")
				pass
		else:
			print("passed")

#exiting/entering phone ui
	if (Input.is_action_just_pressed("UI") and !player.interacting and !inApp):
		if (inUI == false):
			enterUI()
		else:
			exitUI()

#hide/show apps
func hideApps():
	app1.hide()
	app2.hide()
	app3.hide()
	app4.hide()
	app5.hide()
	app6.hide()
	app7.hide()
	app8.hide()
	QRApp.hide()
	pixapp.hide()
	textapp.hide()
	soulapp.hide()
	options.hide()
#	battApp1.hide()
#	battApp2.hide()
#	battApp3.hide()
#	battApp4.hide()
func showApps():
	app1.show()
	app2.show()
	app3.show()
	app4.show()
	app5.show()
	app6.show()
	app7.show()
	app8.show()
	QRApp.show()
	pixapp.show()
	textapp.show()
	soulapp.show()
	options.show()

#show text routine
func show_text(text):
	if(appscreen.is_visible()):
		var t = Timer.new()
		t.set_wait_time(0.025)
		t.set_one_shot(true)
		self.add_child(t)
		var i = 0
		var textaudio = get_node("NinePatchRect/AudioStreamPlayer")
		var label = appscreen.get_node("Label")
		label.set_text("")
		texting = true
		for letter in text:
			if (!interupt):
				i = i+1
				var newText = text.substr(0,i)
				t.start()
				label.set_text("")
				label.set_text(newText)
				textaudio.play()
				yield(t,"timeout")
			else:
				label.set_text(text)
				textaudio.play()
				interupt = false
				break
		texting =false

#updates the app icons using the battleApps array
func updateApps():
	var i = 0
	for app in battleApps:
		i += 1
		print(i)
		print(app)
		print("in for loop")
		var icon = get_node("PhoneUI/App"+str(i)+"/battleapps")
		icon.animation = str(app)
		icon.show()

func enterApp():
	inApp = true
	appscreen.show()
	appscreen.play("open")
	phoneLabel.set_text("")
	hideApps()

func exitApp():
	phone.animation = "default"
	focusedApp = ""
	phoneLabel.set_text("")
	appscreen.play("close")
	yield(appscreen,"animation_finished")
	appscreen.hide()
	showApps()
	if(focused != null):
		focused.grab_focus()
	inApp = false

func appendApp(appName):
	if(!battleApps.has(appName)):
		battleApps.append(appName)
		updateApps()

func enterUI():
	showApps()
	QRApp.grab_focus()
	audio.stream = load("res://Assets/sfx/phone open v4.wav")
	audio.play()
	player.canMove = false
	player.canInteract = false
	player.animationState.travel("Idle")
	inUI = true

func exitUI():
	phone.animation = "default"
	appscreen.animation = "null"
	appscreen.hide()
	hideApps()
	player.canMove = true
	player.canInteract = true
	audio.stream = load("res://Assets/sfx/phone close v4.wav")
	audio.play()
	inUI = false
	focused = get_focus_owner()
	if (focused != null):
		focused.release_focus()

func _on_App1_focus_entered():
	$PhoneUI/App1/Sprite.show()
	audio.stream = load("res://Assets/sfx/menu browse.wav")
	audio.play()
func _on_App1_focus_exited():
	$PhoneUI/App1/Sprite.hide()

func _on_App2_focus_entered():
	$PhoneUI/App2/Sprite.show()
	audio.stream = load("res://Assets/sfx/menu browse.wav")
	audio.play()
func _on_App2_focus_exited():
	$PhoneUI/App2/Sprite.hide()

func _on_Options_focus_entered():
	$PhoneUI/Options/Sprite.show()
	audio.stream = load("res://Assets/sfx/menu browse.wav")
	audio.play()
func _on_Options_focus_exited():
	$PhoneUI/Options/Sprite.hide()

func _on_App3_focus_entered():
	$PhoneUI/App3/Sprite.show()
	audio.stream = load("res://Assets/sfx/menu browse.wav")
	audio.play()
func _on_App3_focus_exited():
	$PhoneUI/App3/Sprite.hide()

func _on_App4_focus_entered():
	$PhoneUI/App4/Sprite.show()
	audio.stream = load("res://Assets/sfx/menu browse.wav")
	audio.play()
func _on_App4_focus_exited():
	$PhoneUI/App4/Sprite.hide()

func _on_App5_focus_entered():
	$PhoneUI/App5/Sprite.show()
	audio.stream = load("res://Assets/sfx/menu browse.wav")
	audio.play()
func _on_App5_focus_exited():
	$PhoneUI/App5/Sprite.hide()

func _on_App6_focus_entered():
	$PhoneUI/App6/Sprite.show()
	audio.stream = load("res://Assets/sfx/menu browse.wav")
	audio.play()
func _on_App6_focus_exited():
	$PhoneUI/App6/Sprite.hide()

func _on_App7_focus_entered():
	$PhoneUI/App7/Sprite.show()
	audio.stream = load("res://Assets/sfx/menu browse.wav")
	audio.play()
func _on_App7_focus_exited():
	$PhoneUI/App7/Sprite.hide()

func _on_App8_focus_entered():
	$PhoneUI/App8/Sprite.show()
	audio.stream = load("res://Assets/sfx/menu browse.wav")
	audio.play()
func _on_App8_focus_exited():
	$PhoneUI/App8/Sprite.hide()

func _on_QRApp_focus_entered():
	$PhoneUI/QRApp/Sprite.show()
	audio.stream = load("res://Assets/sfx/menu browse.wav")
	audio.play()
func _on_QRApp_focus_exited():
	$PhoneUI/QRApp/Sprite.hide()

func _on_TextApp_focus_entered():
	$PhoneUI/TextApp/Sprite.show()
	audio.stream = load("res://Assets/sfx/menu browse.wav")
	audio.play()
func _on_TextApp_focus_exited():
	$PhoneUI/TextApp/Sprite.hide()

func _on_PixApp_focus_entered():
	$PhoneUI/PixApp/Sprite.show()
	audio.stream = load("res://Assets/sfx/menu browse.wav")
	audio.play()
func _on_PixApp_focus_exited():
	$PhoneUI/PixApp/Sprite.hide()

func _on_Soul_focus_entered():
	$PhoneUI/SoulApp/Sprite.show()
	audio.stream = load("res://Assets/sfx/menu browse.wav")
	audio.play()
func _on_Soul_focus_exited():
	$PhoneUI/SoulApp/Sprite.hide()

func _on_BattleApp1_focus_entered():
	$PhoneUI/BattleApp1/Sprite.show()
	audio.stream = load("res://Assets/sfx/menu browse.wav")
	audio.play()
func _on_BattleApp1_focus_exited():
	$PhoneUI/BattleApp1/Sprite.hide()

func _on_BattleApp2_focus_entered():
	$PhoneUI/BattleApp2/Sprite.show()
	audio.stream = load("res://Assets/sfx/menu browse.wav")
	audio.play()
func _on_BattleApp2_focus_exited():
	$PhoneUI/BattleApp2/Sprite.hide()

func _on_BattleApp3_focus_entered():
	$PhoneUI/BattleApp3/Sprite.show()
	audio.stream = load("res://Assets/sfx/menu browse.wav")
	audio.play()
func _on_BattleApp3_focus_exited():
	$PhoneUI/BattleApp3/Sprite.hide()

func _on_BattleApp4_focus_entered():
	$PhoneUI/BattleApp4/Sprite.show()
	audio.stream = load("res://Assets/sfx/menu browse.wav")
	audio.play()
func _on_BattleApp4_focus_exited():
	$PhoneUI/BattleApp4/Sprite.hide()

func _on_Button_pressed():
	print("button1 pressed")
	$PhoneUI/AppScreen/Button/Sprite.play("selected")
	yield($PhoneUI/AppScreen/Button/Sprite,"animation_finished")
	appendApp(QRCode.appName)
	exitApp()
	$PhoneUI/AppScreen/Button.hide()
	$PhoneUI/AppScreen/Button2.hide()
	$PhoneUI/AppScreen/Button/Sprite.play("default")
	$PhoneUI/AppScreen/Button2/Sprite.play("default")
	print("button1 press finished")

func _on_Button2_pressed():
	print("button2 pressed")
	text1seen = false
	$PhoneUI/AppScreen/Button2/Sprite.play("selected")
	yield($PhoneUI/AppScreen/Button2/Sprite,"animation_finished")
	exitApp()
	$PhoneUI/AppScreen/Button.hide()
	$PhoneUI/AppScreen/Button2.hide()
	$PhoneUI/AppScreen/Button/Sprite.play("default")
	$PhoneUI/AppScreen/Button2/Sprite.play("default")
	print("button2 press finished")

func _on_Button_focus_entered():
	$PhoneUI/AppScreen/Button/Sprite.show()
	audio.stream = load("res://Assets/sfx/menu browse.wav")
	audio.play()

func _on_Button_focus_exited():
	$PhoneUI/AppScreen/Button/Sprite.hide()
	audio.stream = load("res://Assets/sfx/menu browse.wav")
	audio.play()

func _on_Button2_focus_entered():
	$PhoneUI/AppScreen/Button2/Sprite.show()
	audio.stream = load("res://Assets/sfx/menu browse.wav")
	audio.play()

func _on_Button2_focus_exited():
	$PhoneUI/AppScreen/Button2/Sprite.hide()
	audio.stream = load("res://Assets/sfx/menu browse.wav")
	audio.play()

func _on_HomeButton_pressed():
	if(inApp):
		exitApp()
		get_tree().set_input_as_handled()
		if($PhoneUI/AppScreen/Button.is_visible()):
			$PhoneUI/AppScreen/Button.hide()
			$PhoneUI/AppScreen/Button2.hide()
	QRApp.grab_focus()
