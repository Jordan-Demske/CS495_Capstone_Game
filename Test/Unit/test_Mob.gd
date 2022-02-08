extends 'res://addons/gut/test.gd'

var Mob = load("res://Mob.tscn")
var _mob = null


func before_each():
	_mob = Mob.instance()


func after_each():
	_mob.free()


func test_method():
	pass
