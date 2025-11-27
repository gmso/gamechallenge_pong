extends CharacterBody2D

enum PlayerSide {LEFT, RIGHT}
@export var side = PlayerSide.RIGHT

enum Mode {MANUAL, BOT}
@export var mode = Mode.MANUAL

var player_speed = 200 # in pixels/sec
var last_known_ball_position: Vector2
var bot_hijacked = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var dist_to_vp = get_viewport_rect().end.x - $CollisionBar.position.x
	if side == PlayerSide.RIGHT:
		$CollisionBar.position.x = dist_to_vp
		$PlayerBar.position.x = dist_to_vp - ($PlayerBar.size.x / 2)


func init_player_manual():
	mode = Mode.MANUAL
	$PlayerBar.color = Color("white")


func init_player_bot():
	mode = Mode.BOT
	$PlayerBar.color = Color("teal")
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	var direction = Vector2.ZERO
	if mode == Mode.MANUAL:
		direction = set_direction_manual()
	elif mode == Mode.BOT:
		direction = set_direction_bot()
		
	velocity = direction * player_speed
	move_and_slide()


func set_direction_manual() -> Vector2:
	if side == PlayerSide.LEFT:
		if Input.is_action_pressed("letter_w"):
			return Vector2.UP
		elif Input.is_action_pressed("letter_s"):
			return Vector2.DOWN
			
	elif side == PlayerSide.RIGHT:
		if Input.is_action_pressed("letter_o"):
			return Vector2.UP
		elif Input.is_action_pressed("letter_l"):
			return Vector2.DOWN
			
	return Vector2.ZERO
	

func set_direction_bot() -> Vector2:
	if bot_hijacked:
		return Vector2.ZERO
	elif position.y < last_known_ball_position.y:
		return Vector2.DOWN
	elif position.y > last_known_ball_position.y:
		return Vector2.UP
	return Vector2.ZERO


func _on_ball_ball_position_updated(ball_pos: Vector2) -> void:
	last_known_ball_position = ball_pos


func _on_timer_start_hijack_bot_timeout() -> void:
	bot_hijacked = true
	$TimerEndHijackBot2.wait_time = randf_range(0.2, 0.7)
	$TimerEndHijackBot2.start()


func _on_timer_end_hijack_bot_2_timeout() -> void:
	bot_hijacked = false
	$TimerStartHijackBot.wait_time = randf_range(4.0, 6.0)
	$TimerStartHijackBot.start()
