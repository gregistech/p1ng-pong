extends KinematicBody2D

signal out_of_bounds

export var base_speed = 500
export var speed_rate = 10
var speed = base_speed

var is_dir_left = true
var rand_y = 0
var rng = RandomNumberGenerator.new()
var screen_size = OS.get_window_size()

func is_out_of_bounds(screen_size):
	if position.x < screen_size.x * 0.2 or position.x > screen_size.x * 0.8:
		return true
	return false

func _ready():
	translate(screen_size / 2)

func _physics_process(delta):
	var velocity = Vector2(1, rand_y) if is_dir_left else Vector2(-1, rand_y)
	if move_and_collide(velocity * speed * delta):
		if is_out_of_bounds(screen_size):
			emit_signal("out_of_bounds")
			queue_free()
			return
		rng.randomize()
		rand_y = rng.randf_range(-0.5, 0.6)
		is_dir_left = !is_dir_left
		speed += speed_rate
