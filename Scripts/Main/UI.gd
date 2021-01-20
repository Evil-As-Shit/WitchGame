extends Control

var inUI = false
var ghostCount = 0
onready var player = get_node("../../YSort/Player")
onready var soul = get_node("../../YSort/Object_Soul")
onready var phone = get_node("PhoneUI")
onready var app1 = get_node("PhoneUI/App1")
onready var soul_notification = get_node("PhoneUI/Soul_Notification")
onready var soul_collected = get_node("PhoneUI/Soul_Collected")
onready var audio = get_node("../../AudioStreamPlayer")
onready var time = get_node("PhoneUI/Time")
func _ready():
	soul_notification.hide()

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

func _input(_event):
	if(inUI):
		if(Input.is_action_just_pressed("e")):
			var focused = get_focus_owner().name
			if(soul != null):
				if(focused == "SoulApp" and soul.nearSoul):
					get_node("../../YSort/Object_Soul/icon").animation = "Collected"
					soul_collected.animation = "collected"
					audio.stream = load("res://Assets/sfx/find ghost v2.wav")
					audio.play()
					player.interacting = true
					get_tree().get_root().set_disable_input(true)
					yield(audio, "finished")
#					print("audio finished")
					player.interacting = false
					get_tree().get_root().set_disable_input(false)
	if (Input.is_action_just_pressed("UI") and !player.interacting):
		if (inUI == false):
			enterUI()
		else:
			exitUI()

func enterUI():
	app1.grab_focus()
	audio.stream = load("res://Assets/sfx/phone open v4.wav")
	audio.play()
	player.canMove = false
	player.canInteract = false
	player.animationState.travel("Idle")
	inUI = true

func exitUI():
	player.canMove = true
	player.canInteract = true
	audio.stream = load("res://Assets/sfx/phone close v4.wav")
	audio.play()
	inUI = false
	var focused = get_focus_owner()
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

