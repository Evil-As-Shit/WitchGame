extends AnimatedSprite

func _ready():
	var _error = SignalController.connect(
			"collected_soul", self, "_on_collected_soul")

func _on_collected_soul(_soul: Soul):
	play("collected")
	yield(self, "animation_finished")
	play("idle")
