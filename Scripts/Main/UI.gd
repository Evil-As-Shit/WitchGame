extends Control


var inUI = false
var ghostCount = 3
var battlemode = false
var texting = false
var interupt = false
var text1seen = false
var qrText = ""
var inApp = false
var focusedApp = ""
var choosing = false
var focused = null
var notEnoughMem = false
signal text_finished
onready var player = get_node("../../YSort/Player")
onready var soul = get_node("../../YSort/Object_Soul")
onready var soulCorrupt = get_node("../../YSort/Object_Soul_Corrupted")
onready var phone = get_node("PhoneUI")
onready var appscreen = get_node("PhoneUI/AppScreen")
onready var soul_notification = get_node("PhoneUI/Soul_Notification")
onready var qr_notification = get_node("PhoneUI/QR_Notification")
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
onready var battleApps = []
onready var soulMoves = {}
onready var moves = []
onready var corruptSouls = []
onready var phoneLabel = get_node("PhoneUI/AppScreen/Label")


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
func _input(event):
	if(Input.is_action_just_pressed("e") and inUI):
		if(!inApp):
			focused = get_focus_owner()
			print(focused.name)
		if(texting):
			print("interupted")
			interupt = true
#			get_tree().get_root().set_input_as_handled()
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
					ghostCount += 1
					player.interacting = false
					get_tree().get_root().set_disable_input(false)
			if(soulCorrupt != null):
				if(soulCorrupt.nearSoulCorrupt):
					if(!corruptSouls.has(soulCorrupt)):
						corruptSouls.append(soulCorrupt)
						randomizeMoves(soulCorrupt,soulMoves)
						updateBattleApps(soulMoves)
					else:
						print("soul already in the system")
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
						soul_notification.hide()
						phone.play("battleIN")
						yield(phone,"animation_finished")
						battApp1.show()
						battApp2.show()
						battApp3.show()
						battApp4.show()
						battlemode = true
						battApp1.grab_focus()
#pressing e on QRApp
		elif(focused.name == "QRApp"):
			var QRCode = get_node("../../YSort/QRCode_"+player.location)
			if(QRCode != null):
				if(QRCode.nearQR):
					if(!inApp):
						qr_notification.hide()
						enterApp()
					if(battleApps.has(QRCode.appName)):
							qrText = "This app is \nalready \ninstalled!"
							yield(appscreen,"animation_finished")
							show_text(qrText,0.025)
							yield(self, "text_finished")
							phone.get_node("HomeButton").grab_focus()
					elif(notEnoughMem):
						if(!texting):
							qrText = "You don't have enough memory!"
							show_text(qrText,0.025)
							yield(self,"text_finished")
							notEnoughMem = false
							phone.get_node("HomeButton").grab_focus()
					elif(choosing):
						if(text1seen):
		#					get_tree().get_root().set_input_as_handled()
							qrText = "Download App? Cost:"+str(QRCode.memCost)+"GB"
							show_text(qrText,0.025)
							choosing = false
							yield(self, "text_finished")
							appscreen.get_node("Button").show()
							appscreen.get_node("Button2").show()
							appscreen.get_node("Button").grab_focus()
						else:
							print("1")
							pass
					elif(!text1seen):
		#				get_tree().get_root().set_input_as_handled()
						qrText = "A sketchy app is available to download from the undernet!"
						text1seen = true
						choosing = true
						yield(appscreen,"animation_finished")
						show_text(qrText,0.025)
					else:
						print("2")
						pass
				else:
					print("3")
					pass
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
	if(focused != null):
		if(focused.name != "SoulApp"):
			battApp1.hide()
			battApp2.hide()
			battApp3.hide()
			battApp4.hide()

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

#yield all input to app screen open/close animation
func yieldToAni():
	get_tree().get_root().set_disable_input(true)
	yield(appscreen,"animation_finished")
	get_tree().get_root().set_disable_input(false)

#show text routine
func show_text(text,speed):
	if(inApp):
		var t = Timer.new()
		t.set_wait_time(speed)
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
		emit_signal("text_finished")

#updates the app icons using the battleApps array
func updateApps():
	var i = 0
	for app in battleApps:
		i += 1
		var icon = get_node("PhoneUI/App"+str(i)+"/battleapps")
		var notification = get_node("PhoneUI/App"+str(i)+"/notification")
		if(!icon.is_visible()):
			print(app)
			icon.animation = str(app)
			icon.show()
			yieldToAni()
			notification.show()
			notification.play("notify")
			yield(notification,"animation_finished")
			notification.hide()
		else:
			pass

func enterApp():
	appscreen.show()
	appscreen.play("open")
	yieldToAni()
	phoneLabel.set_text("")
	yield(appscreen,"animation_finished")
	inApp = true
	hideApps()

func exitApp():
	if(focused.name == "QRApp"):
		text1seen = false
		choosing = false
	if(focused.name == "SoulApp" and soulCorrupt.nearSoulCorrupt):
		phone.play("battleOUT")
		battApp1.hide()
		battApp2.hide()
		battApp3.hide()
		battApp4.hide()
	focusedApp = ""
	phoneLabel.set_text("")
	showApps()
	appscreen.play("close")
	yieldToAni()
	inApp = false
	if(focused != null):
		focused.grab_focus()

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

func updateBattleApps(moves):
	var i = 1
	print(battleApps)
	yield(phone,"animation_finished")
	for app in battleApps:
		i += 1
		var icon = get_node("PhoneUI/BattleApp"+str(i)+"/battleapps")
		print(icon)
		icon.animation = str(app)
		icon.show()

func randomizeMoves(soul,soulmoves):
	if(battleApps.size() < 3):
		print(battleApps.size())
		for app in battleApps:
			var i = 0
			moves = battleApps
			i += 1
		pass
	soulmoves[soul] = moves
	print(soulmoves)
	pass

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

func pressKey():
	var a = InputEventKey.new()
	a.scancode = KEY_E
	a.pressed = true
	Input.parse_input_event(a)

func _on_Button_pressed():
	var QRCode = get_node("../../YSort/QRCode_"+player.location)
	$PhoneUI/AppScreen/Button/Sprite.play("selected")
	yield($PhoneUI/AppScreen/Button/Sprite,"animation_finished")
	$PhoneUI/AppScreen/Button/Sprite.play("default")
	$PhoneUI/AppScreen/Button2/Sprite.play("default")
	$PhoneUI/AppScreen/Button.hide()
	$PhoneUI/AppScreen/Button2.hide()
	if(ghostCount >= QRCode.memCost and !battleApps.has(QRCode.appName)):
		appendApp(QRCode.appName)
		ghostCount -= QRCode.memCost
		exitApp()
		qr_notification.show()
	else:
#		show_text("...",0.25)
		notEnoughMem = true
		pressKey()
		
func _on_Button2_pressed():
	$PhoneUI/AppScreen/Button2/Sprite.play("selected")
	yield($PhoneUI/AppScreen/Button2/Sprite,"animation_finished")
	$PhoneUI/AppScreen/Button/Sprite.play("default")
	$PhoneUI/AppScreen/Button2/Sprite.play("default")
	$PhoneUI/AppScreen/Button.hide()
	$PhoneUI/AppScreen/Button2.hide()
	text1seen = false
	notEnoughMem = false
	exitApp()
	qr_notification.show()


func _on_Button_focus_entered():
	$PhoneUI/AppScreen/Button/Sprite.show()
#	audio.stream = load("res://Assets/sfx/menu browse.wav")
#	audio.play()

func _on_Button_focus_exited():
	$PhoneUI/AppScreen/Button/Sprite.hide()

func _on_Button2_focus_entered():
	$PhoneUI/AppScreen/Button2/Sprite.show()
#	audio.stream = load("res://Assets/sfx/menu browse.wav")
#	audio.play()

func _on_Button2_focus_exited():
	$PhoneUI/AppScreen/Button2/Sprite.hide()

func _on_HomeButton_pressed():
#	get_tree().set_input_as_handled()
	if(inApp):
		exitApp()
		if(focused.name == "SoulApp"):
			soul_notification.show()
			phone.play("battleOUT")
		if(focused.name == "QRApp"):
			qr_notification.show()
		if($PhoneUI/AppScreen/Button.is_visible()):
			$PhoneUI/AppScreen/Button.hide()
			$PhoneUI/AppScreen/Button2.hide()
	QRApp.grab_focus()
