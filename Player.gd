extends Area2D
signal hit
signal coin_grabbed

export var speed = 400 # How fast the player will move
var screen_size # Size of the game window


func _ready():
	hide()


func _process(delta):
	var velocity = Vector2()
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	position += velocity * delta
	position.x = clamp(position.x, 0, get_viewport_rect().size.x)
	position.y = clamp(position.y, 0, get_viewport_rect().size.y)


func _on_Player_body_entered(body):
	if body.is_in_group("coins"):
		emit_signal("coin_grabbed")
		body.free()
	elif body.is_in_group("mobs"):
		hide() # Player disapeers after being hit
		emit_signal("hit")
		$CollisionShape2D.set_deferred("disabled", true)


func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
