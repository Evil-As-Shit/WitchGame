extends Button

var has_focus = false;

func _ready():
	$Sprite.visible = false
	connect("focus_entered", self, "on_focus_entered")
	connect("focus_exited", self, "on_focus_exited")
	
func on_focus_entered():
	if (has_focus == false):
		$AudioStreamPlayer.play()
		$Sprite.visible = true
	has_focus = true

func on_focus_exited():
	$Sprite.visible = false
	has_focus = false
