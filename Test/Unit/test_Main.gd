extends 'res://addons/gut/test.gd'

var Main = load("res://Main.tscn")
var Coin = load("res://Coin.tscn")
var Mob = load("res://Mob.tscn")
var _main = null
var _coin = null
var _mob = null
var score = 0


func before_each():
	_main = Main.instance()
	_coin = Coin.instance()
	_mob = Mob.instance()
	score = 0


func after_each():
	_main.free()
	_coin.free()
	_mob.free()


func test_coin_grabbed():
	_main.coin_grabbed()
	assert_true(_main.get_node("HUD/ScoreLabel").text == '1' )


func test_new_game():
	_main.new_game()
	assert_true(_main.get_node("HUD/ScoreLabel").text == '0' )
	assert_true(_main.get_node("HUD/Message").text == 'Get Ready' )
	assert_true(_main.get_node("Player").position == Vector2(240,450))
	assert_true(_main.get_node("Player").visible)
	assert_false(_main.get_node("Player/CollisionShape2D").disabled)
	assert_false(_main.get_node("StartTimer").paused)
	assert_true(_main.get_node("Music").playing)


func test_on_SpawnTimer_timeout():
	_main._on_SpawnTimer_timeout()
	assert_true(_main.get_node("Mob") != null)


func test_on_CoinTimer_timeout():
	_main._on_CoinTimer_timeout()
	assert_true(_main.get_node("Coin") != null)
