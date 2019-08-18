extends KinematicBody2D

export(bool) var is_left = true
export(int) var speed = 1

var screen_size = OS.get_window_size()

func get_direction(is_left):
	if is_left:
		if Input.is_action_pressed("left_up"):
			return "up"
		elif Input.is_action_pressed("left_down"):
			return "down"
		return
	if Input.is_action_pressed("right_up"):
		return "up"
	elif Input.is_action_pressed("right_down"):
		return "down"
	return false

func _ready():
	var pos_y = screen_size.y / 2
	var pos = Vector2(screen_size.x * 0.2, pos_y) if is_left else Vector2(screen_size.x * 0.8, pos_y)
	translate(pos)

func _physics_process(delta):
	var dir = get_direction(is_left)
	var velocity = Vector2()
	if dir:
		if dir == "up":
			velocity = Vector2(0, -1)
		else:
			velocity = Vector2(0, 1)
		move_and_collide(velocity * speed * delta)


