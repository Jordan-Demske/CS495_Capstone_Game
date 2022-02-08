extends 'res://addons/gut/test.gd'

var HUD = load("res://HUD.tscn")
var _hud = null


func before_each():
	_hud = HUD.instance()


func after_each():
	_hud.free()

func test_show_message():
	_hud.show_message("test")
	assert_true(_hud.get_node("Message").text == "test" )
	assert_true(_hud.get_node("Message").visible == true )

func test_show_game_over():
	_hud.show_game_over()
	assert_true(_hud.get_node("Message").text == "Game Over" )
	assert_true(_hud.get_node("Message").visible == true )
	assert_true(_hud.get_node("StartButton").visible == true )

func test_update_score():
	_hud.update_score(7)
	assert_true(_hud.get_node("ScoreLabel").text == '7' )

func test_on_MessageTimer_timeout():
	_hud._on_MessageTimer_timeout()
	assert_true(_hud.get_node("Message").visible == false )

func test_on_StartButton_pressed():
	_hud._on_StartButton_pressed()
	assert_true(_hud.get_node("StartButton").visible == false )
	watch_signals(_hud)
	_hud._on_StartButton_pressed()
	assert_signal_emitted(_hud, 'start_game')
