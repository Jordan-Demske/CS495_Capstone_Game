extends Area2D
signal hit
signal dead

signal drunk
signal pill_grabbed

export var speed = 600 # How fast the player will move
export var health = 5 # number of times player can get hit

var is_drunk = false


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
		body.free()
		if is_drunk:
			health -= 1
		else:
			health += 1
		emit_signal("pill_grabbed")
		
	elif body.is_in_group("mobs"):
		if is_drunk:
			health -= 1
		else:
			health = 2
		body.free()
		emit_signal("hit")
		emit_signal("drunk") ########## IMPLEMENT LATER
	
	print(health)
	check_if_dead()

func check_if_dead():
	if (health == 0 or health == 10) :
		hide() # Player disapeers after being hit
		emit_signal("dead")
		$CollisionShape2D.set_deferred("disabled", true)


func spawn(pos):
	global_position = pos
	show()
	$CollisionShape2D.disabled = false
	health = 5
