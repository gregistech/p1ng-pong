extends Control

signal start_game

export var screens = {
		"start": ["StartButton", "StartLabel"],
		"game": ["GameScore"],
		"over": ["OverButton", "OverLabel"]
	}                                              

func set_score(score):
	get_node("GameScore").text = str(score)

func disable_all_children():
	for c in get_children():
		c.hide()

func enable_children(names):
	for name in names:
		if name:
			get_node(name).show()

func show_screen(screen):
	disable_all_children()
	enable_children(screens[screen])

func _ready():
	var game_state = get_parent().get_node("GameState")
	if game_state:
		game_state.connect("game_started", self, "_on_GameState_game_started")
		game_state.connect("game_ended", self, "_on_GameState_game_ended")
		game_state.connect("game_scored", self, "_on_GameState_game_scored")
		game_state.connect("show_start", self, "_on_GameState_show_start")

func _on_GameState_show_start():
	show_screen("start")

func _on_GameState_game_started():
	show_screen("game")

func _on_GameState_game_ended():
	show_screen("over")

func _on_GameState_game_scored(score):
	set_score(score)

func _on_StartButton_pressed():
	emit_signal("start_game")

func _on_OverButton_pressed():
	emit_signal("start_game")
