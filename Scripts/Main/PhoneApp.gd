class_name PhoneApp
extends Button

var has_focus = false;

func _ready():
	$Sprite.visible = false
	var _error = connect("focus_entered", self, "on_focus_entered")
	_error = connect("focus_exited", self, "on_focus_exited")
	
	_error = SignalController.connect("entered_qr", self, "on_entered_qr")
	_error = SignalController.connect("entered_soul", self, "on_entered_soul")

func on_entered_qr(b):
	if name == "PhoneAppQR": _set_highlight(b)
	
func on_entered_soul(b):
	if name == "PhoneAppSoul": _set_highlight(b)

func on_focus_entered():
	if (has_focus == false):
		$AudioStreamPlayer.play()
		$Sprite.visible = true
		GameData.appSelected = self
	has_focus = true

func on_focus_exited():
	$Sprite.visible = false
	has_focus = false

func _set_highlight(b):
	if b:
		$SpriteHighlight.play("highlight")
	else:
		$SpriteHighlight.play("none")

func _show_battle_app(toShow):
	if (str(toShow).length() == 0):
		$battleapps.visible = false
	else:
		$battleapps.visible = true
		var icon = $battleapps
		icon.animation = str(toShow)
		icon.visible = true
		
func play_selection():
	$Sprite.play("selected")
	yield($Sprite, "animation_finished")
	$Sprite.play("default")

func play_notification():
	$notification.show()
	$notification.play("notify")
	yield($notification,"animation_finished")
	$notification.hide()
	$notification.play("default")


