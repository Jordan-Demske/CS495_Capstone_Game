extends 'res://addons/gut/test.gd'

var Coin = load("res://Coin.tscn")
var _coin = null


func before_each():
	_coin = Coin.instance()


func after_each():
	_coin.free()


func test_method():
	pass
