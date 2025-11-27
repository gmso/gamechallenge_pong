extends CharacterBody2D

var direction: Vector2 = Vector2.ZERO
var ball_speed = 200 # in pixels/sec

signal ball_position_updated(Vector2)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	prepare()


func _physics_process(_delta: float) -> void:
	velocity = direction * ball_speed
	var collision = move_and_slide()
	if collision:
		direction = direction.bounce(get_last_slide_collision().get_normal())
		$AudioBallHit.play()
	#ball_position_updated.emit(position + get_viewport_rect().get_center())
	ball_position_updated.emit(position)

func stop():
	direction = Vector2.ZERO


func prepare():
	position = Vector2.ZERO
	velocity = Vector2.ZERO
	direction = Vector2.ZERO
	ball_speed = 200


func start():
	randomize_direction()


func randomize_direction():
	var x = randi_range(0,1)
	if x == 0:
		x = -1
	var y = randi_range(0,1)
	if y == 0:
		y = -1
	direction = Vector2(x,y)


func _on_timer_accelerate_ball_timeout() -> void:
	ball_speed += 5
