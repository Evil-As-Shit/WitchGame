extends Control


var inUI = false
var ghostCount = 2
var battlemode = false
var texting = false
var interupt = false
var text1seen = false
var qrText = ""
var inApp = false
var focusedApp = null
var choosing = false
var focused = null
var notEnoughMem = false
var home = false
var focusedName = null
var texttween = Tween.new()
signal text_finished
onready var player = get_node("../../YSort/Player")
onready var soul = null
onready var soulCorrupt = null
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
onready var homeButton = get_node("PhoneUI/HomeButton")
onready var corruptGhost = get_node("PhoneUI/AppScreen/corruptGhost")
onready var battleMoves = get_node("PhoneUI/AppScreen/battleMoves")
onready var ghostLife = get_node("PhoneUI/AppScreen/ghostLife")
onready var battery = get_node("PhoneUI/Battery")
onready var battleApps = []
onready var soulMoves = {}
onready var corruptSouls = []
onready var phoneLabel = get_node("PhoneUI/AppScreen/Label")
onready var dialogue = get_node("../../DialogueParser")

func _ready():
	texttween.connect("tween_step",self,"On_Tween_Step")
	texttween.connect("tween_completed",self,"Tween_Completed")
	appscreen.get_node("Label").add_child(texttween)
	pass

func _physics_process(delta):
	if (inUI):
		phone.position = phone.position.linear_interpolate(Vector2(180,430), delta*10) 
	if (!inUI):
		phone.position = phone.position.linear_interpolate(Vector2(180,900), delta*10) 
	var osTime = OS.get_time()
	var hour = String(osTime.hour)
	var minute = String(osTime.minute)
	var currentTime = hour + ":" + minute
	time.set_text(currentTime)
	memory.set_text(str(ghostCount))

#pressing e when in phone ui
func _input(_event):
	if(Input.is_action_just_pressed("e") and inUI and !player.interacting and home == false):
		if(!inApp):
			focused = get_focus_owner()
			focusedName = focused.name
			if(focused.get_node_or_null ("battleapps") != null):
				if(focused.get_node("battleapps").is_visible()):
					focusedName = focused.get_node("battleapps").animation
#			print(focusedName)
#			print(player.location)
		if(texting):
#			print("interupted")
			interupt = true
#			get_tree().get_root().set_input_as_handled()
#pressing e on soul app
		elif(focusedName == "SoulApp"):
			soul = get_node_or_null("../../YSort/Object_Soul_"+player.location)
			if(soul != null):
				if(soul.nearSoul):
					get_tree().get_root().set_disable_input(true)
					focused.get_node("Sprite").play("selected")
					yield(focused.get_node("Sprite"),"animation_finished")
					focused.get_node("Sprite").play("default")
					get_node("../../YSort/Object_Soul_"+player.location+"/icon").animation = "Collected"
					soul_collected.play("collected")
					audio.stream = load("res://Assets/sfx/find ghost v2.wav")
					audio.play()
					player.interacting = true
					yield(soul_collected,"animation_finished")
					soul_collected.play("idle")
					batteryUse(1)
					ghostCount += 1
					player.interacting = false
					get_tree().get_root().set_disable_input(false)
			soulCorrupt = get_node_or_null("../../YSort/Object_Soul_Corrupted_"+player.location)
			if(soulCorrupt != null):
				if(soulCorrupt.nearSoulCorrupt):
					if(!battlemode):
						get_tree().get_root().set_disable_input(true)
						focused.get_node("Sprite").play("selected")
						yield(focused.get_node("Sprite"),"animation_finished")
						focused.get_node("Sprite").play("default")
						get_tree().get_root().set_disable_input(false)
#						if(!corruptSouls.has(soulCorrupt.name)):
						corruptSouls.append(soulCorrupt.name)
						randomizeMoves(soulCorrupt.name,battleApps)
#						print("first time ghost")
						showBattleApps(soulCorrupt.name)
					if(battlemode):
						if(get_focus_owner() != null):
							focusedApp = get_focus_owner()
							if(focusedApp.name == "BattleApp1"):
								get_tree().get_root().set_disable_input(true)
								focusedApp.get_node("Sprite").play("selected")
								yield(focusedApp.get_node("Sprite"),"animation_finished")
								focusedApp.get_node("Sprite").play("default")
								get_tree().get_root().set_disable_input(false)
								print("BattleApp1 GOOO!!")
							if(focusedApp.name == "BattleApp2"):
								if(get_focus_owner().get_node("battleapps").is_visible()):
									get_tree().get_root().set_disable_input(true)
									focusedApp.get_node("Sprite").play("selected")
									yield(focusedApp.get_node("Sprite"),"animation_finished")
									focusedApp.get_node("Sprite").play("default")
									get_tree().get_root().set_disable_input(false)
									var battleMove = get_focus_owner().get_node("battleapps").animation
									player.interacting = true
									get_tree().get_root().set_disable_input(true)
									moveAniPlayer(battleMove)
								else:
									print("BattleApp2 GOOO!!")
							if(focusedApp.name == "BattleApp3"):
								if(get_focus_owner().get_node("battleapps").is_visible()):
									get_tree().get_root().set_disable_input(true)
									focusedApp.get_node("Sprite").play("selected")
									yield(focusedApp.get_node("Sprite"),"animation_finished")
									focusedApp.get_node("Sprite").play("default")
									get_tree().get_root().set_disable_input(false)
									var battleMove = get_focus_owner().get_node("battleapps").animation
									player.interacting = true
									get_tree().get_root().set_disable_input(true)
									moveAniPlayer(battleMove)
								else:
									print("BattleApp3 GOOO!!")
							if(focusedApp.name == "BattleApp4"):
								if(get_focus_owner().get_node("battleapps").is_visible()):
									get_tree().get_root().set_disable_input(true)
									focusedApp.get_node("Sprite").play("selected")
									yield(focusedApp.get_node("Sprite"),"animation_finished")
									focusedApp.get_node("Sprite").play("default")
									get_tree().get_root().set_disable_input(false)
									var battleMove = get_focus_owner().get_node("battleapps").animation
									player.interacting = true
									get_tree().get_root().set_disable_input(true)
									moveAniPlayer(battleMove)
								else:
									print("BattleApp4 GOOO!!")
						else:
							pass
					if(!inApp):
						get_tree().get_root().set_disable_input(true)
						player.interacting = true
						focusedApp = get_focus_owner()
						focusedApp.release_focus()
						enterApp(focusedName)
						soul_notification.play("null")
						phone.play("battleIN")
						yield(appscreen,"animation_finished")
						corruptGhost.show()
						ghostLife.show()
						ghostLife.play("default")
						corruptGhost.play("intro")
						soulCorrupt.get_node("Sprite").play("fight")
						yield(corruptGhost,"animation_finished")
						corruptGhost.play("default")
						yield(ghostLife,"animation_finished")
						battApp1.show()
						battApp2.show()
						battApp3.show()
						battApp4.show()
						battlemode = true
						battApp1.grab_focus()
						ghostLife.stop()
						player.interacting = false
						get_tree().get_root().set_disable_input(false)
#pressing e on QRApp
		elif(focusedName == "QRApp"):
			focusedApp = get_focus_owner()
			var QRCode = get_node("../../YSort/QRCode_"+player.location)
#			print(QRCode.appName)
			if(QRCode != null):
				if(QRCode.nearQR):
					if(!inApp):
						qr_notification.play("null")
						get_tree().get_root().set_disable_input(true)
						focusedApp.get_node("Sprite").play("selected")
						yield(focusedApp.get_node("Sprite"),"animation_finished")
						focusedApp.get_node("Sprite").play("default")
						get_tree().get_root().set_disable_input(false)
						enterApp(focusedName)
					if(home):
						pass
					elif(battleApps.has(QRCode.appName)):
							print("app already installed")
							qrText = "This app is \nalready \ninstalled!"
							yield(appscreen,"animation_finished")
							show_text(qrText,0.025)
							yield(self, "text_finished")
							phone.get_node("HomeButton").grab_focus()
							home = true
					elif(notEnoughMem):
							print("not enough mem")
							qrText = "You don't have enough memory!"
							show_text(qrText,0.025)
							yield(self,"text_finished")
							phone.get_node("HomeButton").grab_focus()
							home = true
					elif(choosing):
						if(text1seen):
							print("second screen")
		#					get_tree().get_root().set_input_as_handled()
							qrText = "Download App? Cost:"+str(QRCode.memCost)+"GB"
							show_text(qrText,0.025)
							yield(self, "text_finished")
							appscreen.get_node("Button").show()
							appscreen.get_node("Button2").show()
							appscreen.get_node("Button").grab_focus()
							text1seen = false
#						else:
#							print("1")
#							pass
					elif(!text1seen):
						print("first screen")
		#				get_tree().get_root().set_input_as_handled()
						qrText = "A sketchy app is available to download from the undernet!"
						yield(appscreen,"animation_finished")
						text1seen = true
						choosing = true
						show_text(qrText,0.025)
					else:
#						print("2")
						pass
				else:
#					print("3")
					pass
#pressing e on Options
		elif(focusedName == "Options"):
			if(inApp):
				if(!text1seen):
					focusedApp = get_focus_owner().name
				appscreen.get_node("Uninstall").hide()
				print(focusedApp)
				if(focusedApp != "HomeButton"):
					if(battleApps.size() != 0):
						if(choosing):
							appscreen.play("close")
							var i = 1
							for app in battleApps:
								get_node("PhoneUI/App"+str(i)).show()
								i += 1
							show_text("",0.025)
							app1.grab_focus()
							choosing = false
						elif(text1seen and !choosing):
							appscreen.play("close")
							yieldToAni()
							if(get_focus_owner().get_node_or_null("battleapps") != null):
								get_focus_owner().get_node("battleapps").get_animation()
								battleApps.erase(get_focus_owner().get_node("battleapps").get_animation())
								var QRCode = get_node("../../YSort/QRCode_"+player.location)
								ghostCount += QRCode.memCost
								updateApps()
								exitApp()
							else:
								exitApp()
						else:
							show_text("Which App Would You Like To Uninstall???",0.025)
							yield(self,"text_finished")
							choosing = true
							text1seen = true
					else:
						show_text("You don't have any apps to uninstall :p",0.025)
						yield(self,"text_finished")
						homeButton.grab_focus()
			elif(!inApp):
				get_tree().get_root().set_disable_input(true)
				get_node("PhoneUI/Options/Sprite").play("selected")
				yield(get_node("PhoneUI/Options/Sprite"),"animation_finished")
				get_tree().get_root().set_disable_input(false)
				enterApp(focusedName)
				yield(appscreen,"animation_finished")
				get_node("PhoneUI/Options/Sprite").play("default")
				appscreen.get_node("Uninstall").show()
				appscreen.get_node("Uninstall").grab_focus()
		elif(focusedName == "Uninstall"):
#			appscreen.hide()
#			print("uninstall")
			pass
#pressing e on TextApp
		elif(focusedName == "TextApp"):
			if(!inApp):
				focusedApp = get_focus_owner()
				get_tree().get_root().set_disable_input(true)
				focusedApp.get_node("Sprite").play("selected")
				yield(focusedApp.get_node("Sprite"),"animation_finished")
				focusedApp.get_node("Sprite").play("default")
				get_tree().get_root().set_disable_input(false)
				enterApp(focusedName)
				phone.get_node("HomeButton").grab_focus()
#pressing e on PixApp
		elif(focusedName == "PixApp"):
			if(!inApp):
				focusedApp = get_focus_owner()
				get_tree().get_root().set_disable_input(true)
				focusedApp.get_node("Sprite").play("selected")
				yield(focusedApp.get_node("Sprite"),"animation_finished")
				focusedApp.get_node("Sprite").play("default")
				get_tree().get_root().set_disable_input(false)
				enterApp(focusedName)
				phone.get_node("HomeButton").grab_focus()
#exiting/entering phone ui
	if (Input.is_action_just_pressed("UI") and !player.interacting):
		if(!inApp):
			if (inUI == false):
				enterUI()
			else:
				exitUI()
		elif(texting):
#			print("interupted")
			interupt = true
			print("interupt")
#			get_tree().get_root().set_input_as_handled()
		elif(inApp):
			audio.stream = load("res://Assets/sfx/menu back v2.wav")
			audio.play()
			exitApp()
		else:
			pass

func ghostAttack():
	var t = Timer.new()
	t.set_wait_time(0.75)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t,"timeout")
	corruptGhost.play("attack")
	yield(corruptGhost,"animation_finished")
	corruptGhost.play("default")
	t.set_wait_time(0.1)
	var phoneUse = 1
	for i in phoneUse:
		batteryUse(1)
		t.start()
		yield(t,"timeout")
	get_node("PhoneUI/"+focusedApp.name).grab_focus()
	get_tree().get_root().set_disable_input(false)
	player.interacting = false

func moveAniPlayer(move):
	var t = Timer.new()
	t.set_wait_time(0.1)
	t.set_one_shot(true)
	self.add_child(t)
#	focusedApp.get_node("Sprite").play("selected")
#	yield(focusedApp.get_node("Sprite"),"animation_finished")
#	focusedApp.get_node("Sprite").play("default")
	get_node("PhoneUI/"+focusedApp.name).release_focus()
	battleMoves.show()
	battleMoves.play(move)
	yield(battleMoves,"animation_finished")
	battleMoves.hide()
	battleMoves.play("null")
	var damage = 2
	for i in damage:
		var life = ghostLife.frame
#		print(life)
		life -= 1
		ghostLife.frame = life
		t.start()
		yield(t,"timeout")
		if(ghostLife.frame == 0):
			ghostDecrypt()
			pass
	if(ghostLife.frame > 0):
		ghostAttack()

func ghostDecrypt():
	corruptGhost.play("decrypt")
	yield(corruptGhost,"animation_finished")
	corruptGhost.play("null")
	player.interacting = false
	exitApp()
	pass

func chargeBattery():
	var tempaudio = get_node("NinePatchRect/AudioStreamPlayer")
	get_tree().get_root().set_disable_input(true)
	var t = Timer.new()
	t.set_wait_time(0.5)
	t.set_one_shot(true)
	self.add_child(t)
	for i in (10-battery.frame):
		battery.frame += 1
		t.start()
		tempaudio.play()
		yield(t,"timeout")
	battery.frame = 11
	t.set_wait_time(0.1)
	t.start()
	tempaudio.play()
	yield(t,"timeout")
	battery.frame = 10
	t.start()
	yield(t,"timeout")
	battery.frame = 11
	t.start()
	tempaudio.play()
	yield(t,"timeout")
	battery.frame = 10
	t.start()
	yield(t,"timeout")
	battery.frame = 10
	t.start()
	yield(t,"timeout")
	battery.frame = 10
	t.start()
	yield(t,"timeout")
	battery.frame = 10
	t.start()
	yield(t,"timeout")
	battery.frame = 10
	dialogue.texting = false
	get_tree().get_root().set_disable_input(false)
#	get_node("../../DialogueParser").choices["phoneCharged"] = true
#	pressKey()

func batteryUse(amount):
	var life = battery.frame
#	print(life)
	life -= amount
	battery.frame = life
	if(battery.frame == 0):
		phoneDed()
#hide/show apps

func phoneDed():
	phone.animation = "ded"
	#todo: disable the things
	pass

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

func On_Tween_Step(_object,_key,_elapsed,_value):
	if(!interupt):
		if(texting):
			var tempaudio = get_node("NinePatchRect/AudioStreamPlayer")
			tempaudio.play()
	else:
		texting = false
		texttween.remove_all()
		texttween.emit_signal("tween_completed")
		emit_signal("text_finished")
#		texttween.reset_all()
		print("tweens_stopped")
		interupt = false
		appscreen.get_node("Label").set_percent_visible(1)

func Tween_Completed(_object,_key):
	print("tween completed")
	emit_signal("text_finished")
	texttween.remove_all()
	texting = false
#show text routine

func show_text(text, _target):
	if(inApp):
		var length = text.length()
		var t = 0.025
		var temptime = length * t
		appscreen.get_node("Label").set_text(text)
		texting = true
		appscreen.get_node("Label").set_percent_visible(0)
		if(!interupt):
			texttween.interpolate_property(appscreen.get_node("Label"),"percent_visible",0,1,temptime,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
			texttween.start()


#func show_text(text,speed):
#	if(inApp):
#		var t = Timer.new()
#		t.set_wait_time(speed)
#		t.set_one_shot(true)
#		self.add_child(t)
#		var i = 0
#		var textaudio = get_node("NinePatchRect/AudioStreamPlayer")
#		var label = appscreen.get_node("Label")
#		label.set_text("")
#		texting = true
#		for letter in text:
#			if (!interupt):
#				i = i+1
#				var newText = text.substr(0,i)
#				t.start()
#				label.set_text("")
#				label.set_text(newText)
#				textaudio.play()
#				yield(t,"timeout")
#			else:
#				label.set_text(text)
#				textaudio.play()
#				interupt = false
#				break
#		texting =false
#		emit_signal("text_finished")

#updates the app icons using the battleApps array
func updateApps():
	var i = 0
	for n in 2:
		if(get_node("PhoneUI/App"+str(n+1)+"/battleapps").is_visible()):
			get_node("PhoneUI/App"+str(n+1)+"/battleapps").hide()
	for apps in battleApps:
		i += 1
		var icon = get_node("PhoneUI/App"+str(i)+"/battleapps")
		
#		if(!icon.is_visible()):
#		print(app)
		icon.animation = str(apps)
		icon.show()
	if(choosing == true):
		yieldToAni()
		var notification = get_node("PhoneUI/App"+str(i)+"/notification")
		notification.show()
		notification.play("notify")
		get_tree().get_root().set_disable_input(true)
		player.interacting = true
		yield(notification,"animation_finished")
		player.interacting = false
		get_tree().get_root().set_disable_input(false)
		notification.hide()
		notification.play("default")

func enterApp(appName):
	audio.stream = load("res://Assets/sfx/phone open v4.wav")
	audio.play()
	get_tree().get_root().set_disable_input(true)
	inApp = true
	appscreen.show()
	appscreen.play("open")
	yieldToAni()
	if(appName == "TextApp"):
		appscreen.play("otb")
	phoneLabel.set_text("")
	yield(appscreen,"animation_finished")
	hideApps()
	get_tree().get_root().set_disable_input(false)

func exitApp():
	audio.stream = load("res://Assets/sfx/menu back v2.wav")
	audio.play()
	get_tree().get_root().set_disable_input(true)
	texttween.remove_all()
	player.interacting = true
	if($PhoneUI/AppScreen/Button.is_visible()):
		$PhoneUI/AppScreen/Button.hide()
		$PhoneUI/AppScreen/Button2.hide()
	if(focusedName == "Options"):
		appscreen.get_node("Uninstall").hide()
		choosing = false
		text1seen = false
	if(focusedName == "QRApp"):
		text1seen = false
		choosing = false
		notEnoughMem = false
		print("resetting qrapp")
		if(choosing == true):
			$PhoneUI/AppScreen/Button.hide()
			$PhoneUI/AppScreen/Button2.hide()
		if(home):
			home = false
		qr_notification.play("default")
	if(focusedName == "SoulApp" and soulCorrupt.nearSoulCorrupt):
		battlemode = false
		soulCorrupt.get_node("Sprite").play("unfight")
		yield(soulCorrupt.get_node("Sprite"),"animation_finished")
		if(ghostLife.frame == 0):
			var pos = soulCorrupt.get_position()
			corruptSouls.remove(soulCorrupt.name)
			soulMoves.erase(soulCorrupt.name)
			soulCorrupt.queue_free()
			var newsoul = load("res://Scenes/Objects/Object_Soul.tscn")
			var s = newsoul.instance()
			get_node("../../YSort").add_child(s)
			s.position = pos
			s.set_name("Object_Soul_"+player.location)
		else:
			soulCorrupt.get_node("Sprite").play("default")
		phone.play("battleOUT")
		corruptGhost.play("null")
		corruptGhost.hide()
		ghostLife.play("null")
		ghostLife.hide()
		soul_notification.play("default")
		battApp1.hide()
		battApp2.hide()
		battApp3.hide()
		battApp4.hide()
	player.interacting = false
	showApps()
	appscreen.play("close")
	yieldToAni()
	focusedApp = null
	phoneLabel.set_text("")
	inApp = false
#	if(focused != null):
#		focused.grab_focus()
	homeButton.grab_focus()
	get_tree().get_root().set_disable_input(false)

func appendApp(name):
	if(!battleApps.has(name)):
		battleApps.append(name)
		updateApps()
		batteryUse(1)

func enterUI():
	showApps()
	homeButton.grab_focus()
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

func showBattleApps(soulname):
	var i = 1
	yield(phone,"animation_finished")
	print("showingmoves")
	for app in soulMoves[soulname]:
		print(app)
		i += 1
		var icon = get_node("PhoneUI/BattleApp"+str(i)+"/battleapps")
		icon.animation = str(app)
		icon.show()

func randomizeMoves(soulname, battapps):
	if(battleApps.size() < 3):
		print("populating moves")
		soulMoves[soulname] = battapps.duplicate()

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
	var a = InputEventAction.new()
	a.action = "e"
	a.pressed = true
	Input.parse_input_event(a)
	a.pressed = false
	Input.parse_input_event(a)
	
	
func _on_Button_pressed():
	print("yes pressed")
	player.interacting = true
	get_tree().get_root().set_disable_input(true)
	var QRCode = get_node("../../YSort/QRCode_"+player.location)
	$PhoneUI/AppScreen/Button/Sprite.play("selected")
	yield($PhoneUI/AppScreen/Button/Sprite,"animation_finished")
	$PhoneUI/AppScreen/Button/Sprite.play("default")
	$PhoneUI/AppScreen/Button2/Sprite.play("default")
	$PhoneUI/AppScreen/Button.hide()
	$PhoneUI/AppScreen/Button2.hide()
	get_tree().get_root().set_disable_input(false)
	if(ghostCount >= QRCode.memCost and !battleApps.has(QRCode.appName)):
		appendApp(QRCode.appName)
		ghostCount -= QRCode.memCost
		exitApp()
		qr_notification.play("default")
	if(ghostCount < QRCode.memCost and choosing):
		print("notenoughmem")
		notEnoughMem = true
		player.interacting = false
		pressKey()
	choosing = false
	player.interacting = false
func _on_Button2_pressed():
	player.interacting = true
	print("no pressed")
	get_tree().get_root().set_disable_input(true)
	choosing = false
	$PhoneUI/AppScreen/Button2/Sprite.play("selected")
	yield($PhoneUI/AppScreen/Button2/Sprite,"animation_finished")
	$PhoneUI/AppScreen/Button/Sprite.play("default")
	$PhoneUI/AppScreen/Button2/Sprite.play("default")
	$PhoneUI/AppScreen/Button.hide()
	$PhoneUI/AppScreen/Button2.hide()
	exitApp()
	qr_notification.play("default")
	get_tree().get_root().set_disable_input(false)
	player.interacting = false

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
	focusedApp = get_focus_owner().name
	home = false
	if(inApp):
		audio.stream = load("res://Assets/sfx/menu back v2.wav")
		audio.play()
		exitApp()
#		if(focused.name == "QRApp"):
#			qr_notification.show()
	homeButton.grab_focus()

func _on_Uninstall_pressed():
	
	pass # Replace with function body.
