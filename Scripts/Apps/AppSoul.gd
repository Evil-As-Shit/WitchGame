class_name AppSoul
extends Node

static func is_near_soul():
	return GameData.nearestSoul != null

static func run():
	GameData.appSelected.play_selection()
	GameData.nearestSoul.collect()
	SignalController.emit_signal("collected_soul", GameData.nearestSoul)
