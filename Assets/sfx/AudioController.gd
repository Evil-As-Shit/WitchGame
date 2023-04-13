extends AudioStreamPlayer

func _ready():
	var _error = SignalController.connect(
			"collected_soul", self, "_on_collected_soul")

func _on_collected_soul(_soul: Soul):
	self.stream = load("res://Assets/sfx/find ghost v2.wav")
	play()
