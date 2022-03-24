extends Node

export (PackedScene) var Mob
export (PackedScene) var Coin
var score = 0
var distortion = false
var d_speed = .1

onready var shader_value = $HUD/ColorRect.material.get_shader_param("dist")


func _ready():
	randomize()


func _process(delta):
	if($Player.is_drunk):
		shader_value += d_speed
	else: shader_value -= d_speed/2
	
	shader_value = clamp(shader_value, 0.0, 5.0)
	
	$HUD/ColorRect.material.set_shader_param("dist", shader_value)


func game_over():
	$HUD.show_game_over()
	$HUD/StatusBar.hide()
	$PointTimer.stop()
	$SpawnTimer.stop()
	$CoinTimer.stop()
	$DeteriorationTimer.stop()
	$Music.stop()
	$DeathSound.play()
	get_tree().call_group_flags(SceneTree.GROUP_CALL_REALTIME, "mobs", "queue_free")
	get_tree().call_group_flags(SceneTree.GROUP_CALL_REALTIME, "coins", "queue_free")


func player_hit():
	$DrunkTimer.start()
	if $Player.is_drunk:
		$HUD.move_marker(-1)
	else:
		$Player.is_drunk = true
		$HUD.set_to_position(2)
		## IMPLEMENT DISTORTED UI ANIMATIONS


func pill_grabbed():
	if $Player.is_drunk:
		$HUD.move_marker(-1)
	else:
		$HUD.move_marker(1)


func new_game():
	score = 0
	$HUD/StatusBar.show()
	$HUD.set_to_position(5)
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	$Player.spawn(Vector2(get_viewport().size.x/2, get_viewport().size.y/2))
	$StartTimer.start()
	$Music.play()


func _on_StartTimer_timeout():
	$SpawnTimer.start()
	$CoinTimer.start()
	$PointTimer.start()
	$DeteriorationTimer.start()


func _on_SpawnTimer_timeout():
	var mob = Mob.instance()
	_spawn_child(mob)


func _on_CoinTimer_timeout():
	var coin = Coin.instance()
	_spawn_child(coin)


func _spawn_child(child):
	var spawn_point = Vector2(rand_range(0, get_viewport().size.x),0)
	add_child(child)
	child.position = spawn_point
	child.linear_velocity = (Vector2(0, rand_range(child.min_speed, child.max_speed)))


func _on_PointTimer_timeout():
	score += 1
	$HUD.update_score(score)


func _on_DrunkTimer_timeout():
	## disable drunk distortion effects
	$Player.is_drunk = false
	print($Player.is_drunk)


func _on_DeteriorationTimer_timeout():
		$HUD.move_marker(-1)
		$Player.health -= 1
		$Player.check_if_dead()
