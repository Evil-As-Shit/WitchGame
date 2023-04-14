class_name EnableInputCommand
extends Command

var _root: Node
var _is_enable: bool

func _init(root: Node, is_enable: bool):
	_root = root
	_is_enable = is_enable

func _activate():
	_root.set_disable_input(!_is_enable)
