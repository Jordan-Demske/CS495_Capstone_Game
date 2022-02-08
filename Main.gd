extends Node

export (PackedScene) var Mob
export (PackedScene) var Coin
var score = 0


func _ready():
	randomize()


func game_over():
	$HUD.show_game_over()
	$SpawnTimer.stop()
	$CoinTimer.stop()
	$Music.stop()
	$DeathSound.play()
	get_tree().call_group_flags(SceneTree.GROUP_CALL_REALTIME, "mobs", "queue_free")
	get_tree().call_group_flags(SceneTree.GROUP_CALL_REALTIME, "coins", "queue_free")

func coin_grabbed():
	score += 1
	$HUD.update_score(score)


func new_game():
	score = 0
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$Music.play()


func _on_StartTimer_timeout():
	$SpawnTimer.start()
	$CoinTimer.start()


func _on_SpawnTimer_timeout():
	$SpawnPath/SpawnLocation.offset = randi()
	var mob = Mob.instance()
	add_child(mob)
	var direction = $SpawnPath/SpawnLocation.rotation + PI / -2
	mob.position = $SpawnPath/SpawnLocation.position
	mob.linear_velocity = (Vector2(rand_range(mob.min_speed, mob.max_speed), 0)).rotated(direction)


func _on_CoinTimer_timeout():
	$SpawnPath/SpawnLocation.offset = randi()
	var coin = Coin.instance()
	add_child(coin)
	var direction = $SpawnPath/SpawnLocation.rotation + PI / -2
	coin.position = $SpawnPath/SpawnLocation.position
	coin.linear_velocity = (Vector2(rand_range(coin.min_speed, coin.max_speed), 0)).rotated(direction)
