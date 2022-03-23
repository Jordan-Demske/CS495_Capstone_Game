extends 'res://addons/gut/test.gd'

var Player = load("res://Player.tscn")
var Coin = load("res://Coin.tscn")
var Mob = load("res://Mob.tscn")
var _player = null
var _coin = null
var _mob = null


func before_each():
	_player = Player.instance()


func after_each():
	_player.free()


func test_on_Player_body_entered_coin():
	_coin = Coin.instance()
	watch_signals(_player)
	_player._on_Player_body_entered(_coin)
	assert_signal_emitted(_player, 'coin_grabbed')
	assert_signal_not_emitted(_player, 'hit')
	assert_freed(_coin, 'Is Free.')
	
	
func test_on_Player_body_entered_mob():
	_mob = Mob.instance()
	watch_signals(_player)
	_player._on_Player_body_entered(_mob)
	assert_signal_emitted(_player, 'hit')
	assert_signal_not_emitted(_player, 'coin_grabbed')


func test_start():
	_player.start( Vector2(0,0) )
	assert_true(_player.position == Vector2(0,0))
	assert_true(_player.visible)
	assert_true(_player.get_node("CollisionShape2D").disabled == false )


func test_ready():
	_player._ready()
	assert_false(_player.visible)
