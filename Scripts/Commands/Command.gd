class_name Command

var _is_activated: bool = false

var _sub_commands = []

func _activate():
	pass

func _update(delta: float):
	if (_is_activated == false):
		_is_activated = true
		_activate()
	if (_sub_commands.size() > 0):
		var sub_command: Command = _sub_commands[0]
		sub_command._update(delta)
		if (sub_command._is_complete() == true):
			sub_command._terminate()
			_sub_commands.remove(0)

func _terminate():
	pass

func _is_complete() -> bool:
	return _is_activated and _sub_commands.size() == 0
