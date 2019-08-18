extends Node

signal game_ended
signal game_started
signal game_scored
signal show_start

var ball = load("res://Scenes/Ball.tscn")
var score = 0

onready var score_timer = $ScoreTimer
onready var hud = get_parent().get_node("HUD")

func _ready():
	if hud:
		hud.connect("start_game", self, "_on_HUD_start_game")
	emit_signal("show_start")

func set_score(new_score):
	score = new_score
	emit_signal("game_scored", score)

func create_ball(ball):
	var ball_inst = ball.instance()
	get_parent().add_child(ball_inst)
	ball_inst.connect("out_of_bounds", self, "_on_Ball_out_of_bounds")

func start_game():
	create_ball(ball)
	emit_signal("game_started")
	score_timer.start()

func _on_HUD_start_game():
	start_game()

func _on_Ball_out_of_bounds():
	emit_signal("game_ended")
	set_score(0)
	score_timer.stop()

func _on_ScoreTimer_timeout():
	set_score(score + 1)
