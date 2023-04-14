extends AnimatedSprite

func _ready():
	var _error = SignalController.connect(
			"collected_soul", self, "_on_collected_soul")

func _on_collected_soul(_soul: Soul):
	GameData.commands.append(PlayAnimationCommand.new(self, "collected", true))
	GameData.commands.append(PlayAnimationCommand.new(self, "idle", false))
