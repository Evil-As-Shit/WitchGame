class_name AppSoul
extends Node

static func is_near_soul():
	return GameData.nearestSoul != null

static func run():
	print("AppSoul is running!")
	GameData.appSelected.play_selection()
	
	SignalController.emit_signal("collected_soul", GameData.nearestSoul)
