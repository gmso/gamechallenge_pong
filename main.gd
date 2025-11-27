extends Node

var score_left: int = 0
var score_right: int = 0
var SCORE_TO_WIN: int = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AudioBackground.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

func restart_ball():
	$Ball.prepare()
	await get_tree().create_timer(2.0).timeout
	$Ball.start()

func restart_scores():
	score_left = 0
	$HUD/ScoreLeft.text = str(score_left)
	score_right = 0
	$HUD/ScoreRight.text = str(score_right)
	
	
func start_new_game():
	$HUD.hide_buttons_and_hint()
	restart_scores()
	restart_ball()
	$AudioGameStart.play()

func _on_walls_left_edge_crossed() -> void:
	$AudioScore.play()
	score_right += 1
	$HUD/ScoreRight.text = str(score_right)
	if score_right == SCORE_TO_WIN:
		$Ball.stop()
		$HUD.show_winner("Right")
		$AudioBackground.stop()
		$AudioGameFinished.play()
	else:
		restart_ball()

func _on_walls_right_edge_crossed() -> void:
	$AudioScore.play()
	score_left += 1
	$HUD/ScoreLeft.text = str(score_left)
	if score_left == SCORE_TO_WIN:
		$Ball.stop()
		$HUD.show_winner("Left")
		$AudioBackground.stop()
		$AudioGameFinished.play()
	else:
		restart_ball()

func _on_hud_start_game_1_player_requested() -> void:
	$PlayerLeft.init_player_manual()
	$PlayerRight.init_player_bot()
	start_new_game()

func _on_hud_start_game_2_players_requested() -> void:
	$PlayerLeft.init_player_manual()
	$PlayerRight.init_player_manual()
	start_new_game()

func _on_hud_start_game_auto_requested() -> void:
	$PlayerLeft.init_player_bot()
	$PlayerRight.init_player_bot()
	start_new_game()


func _on_hud_prepare_for_new_game_requested() -> void:
	$AudioBackground.play()
