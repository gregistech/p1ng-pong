extends Node

func _ready():
	var screen_size = OS.get_window_size()
	var collider_pos = [Vector2(0, 0), Vector2(0, 0), Vector2(screen_size.x, screen_size.y), Vector2(screen_size.x, screen_size.y)]
	var collider_size = [Vector2(screen_size.x, 10), Vector2(10, screen_size.y), Vector2(-screen_size.x, 10), Vector2(10, -screen_size.y)]
	for i in range(4):
		var body = StaticBody2D.new()
		var collider = CollisionShape2D.new()
		var shape = RectangleShape2D.new()
		add_child(body)
		shape.set_extents(Vector2(collider_size[i].x, collider_size[i].y))
		collider.set_shape(shape)
		body.add_child(collider)
		body.position = Vector2(collider_pos[i].x, collider_pos[i].y)
