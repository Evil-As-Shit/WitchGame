class_name PlayAnimationCommand
extends Command

var _sprite: AnimatedSprite
var _anim_name: String
var _is_wait: bool
var _is_anim_finished: bool

func _init(sprite: AnimatedSprite, anim_name: String, is_wait: bool):
	_sprite = sprite
	_anim_name = anim_name
	_is_wait = is_wait

func _activate():
	_sprite.play(_anim_name)
	print("playing " + _sprite.name + "'s " + _anim_name)
	_is_anim_finished = not _is_wait
	if (_is_wait):
		_sprite.connect("animation_finished", self, "_on_animation_finished")
	
func _is_complete() -> bool:
	return _is_anim_finished

func _on_animation_finished():
	_is_anim_finished = true
