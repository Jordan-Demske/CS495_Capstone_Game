extends Node

export (PackedScene) var Mob
export (PackedScene) var Coin
var score = 0


func _ready():
	randomize()


func game_over():
	$HUD.show_game_over()
	$PointTimer.stop()
	$SpawnTimer.stop()
	$CoinTimer.stop()
	$Music.stop()
	$DeathSound.play()
	get_tree().call_group_flags(SceneTree.GROUP_CALL_REALTIME, "mobs", "queue_free")
	get_tree().call_group_flags(SceneTree.GROUP_CALL_REALTIME, "coins", "queue_free")


func player_hit():
	# MOVE STATUS MARK BASED ON STATUS
	pass


func pill_grabbed(is_drunk):
	if is_drunk:
		$HUD.move_marker(-1)
	else:
		$HUD.move_marker(1)


func new_game():
	score = 0
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	$Player.spawn(Vector2(get_viewport().size.x/2, get_viewport().size.y/2))
	$StartTimer.start()
	$Music.play()


func _on_StartTimer_timeout():
	$SpawnTimer.start()
	$CoinTimer.start()
	$PointTimer.start()


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
