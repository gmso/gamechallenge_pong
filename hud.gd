extends Control

signal start_game_1_player_requested
signal start_game_2_players_requested
signal start_game_auto_requested
signal prepare_for_new_game_requested

# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
#	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_button_1_player_pressed() -> void:
	$WinnerMessage.hide()
	start_game_1_player_requested.emit()

func _on_button_2_players_pressed() -> void:
	$WinnerMessage.hide()
	start_game_2_players_requested.emit()

func _on_button_auto_pressed() -> void:
	$WinnerMessage.hide()
	start_game_auto_requested.emit()

func hide_buttons_and_hint():
	$Hint.hide()
	$Button1Player.hide()
	$Button2Players.hide()
	$ButtonAuto.hide()

func show_winner(player_name: String) -> void:
	$WinnerMessage.text = " ".join([player_name, "wins!"])
	$WinnerMessage.show()
	await get_tree().create_timer(3.0).timeout
	$ButtonPlayAgain.show()


func _on_button_play_again_pressed() -> void:
	$WinnerMessage.hide()
	$ButtonPlayAgain.hide()
	$Hint.show()
	$Button1Player.show()
	$Button2Players.show()
	$ButtonAuto.show()
	prepare_for_new_game_requested.emit()
