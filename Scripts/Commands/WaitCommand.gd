class_name WaitCommand
extends Command

var _time: float = 0

func _init(time: float):
	_time = time

func _update(delta: float):
	_time -= delta
	
func _is_complete() -> bool:
	return _time <= 0
