extends CharacterBody2D
class_name EnemyPaddle

@export var ball: Ball

const SPEED = 200.0

var allowed_to_move: bool = false

func start(p_position: Vector2) -> void:
	global_position = p_position
	await get_tree().create_timer(1.0).timeout
	allowed_to_move = true

func _physics_process(delta: float) -> void:
	if allowed_to_move:
		_move_enemy(delta)
		move_and_collide(velocity)

func _on_restart(_ball_position: Vector2, _home_position: Vector2, away_position: Vector2, _start_direction: float):
	allowed_to_move = false
	start(away_position)

func _move_enemy(delta: float):
	if ball.velocity.normalized().x > 0.0 && ball.global_position.x > 458.0:
		global_position.y += clampf(ball.global_position.y - global_position.y, -1, 1) * SPEED * delta
	global_position.y = clampf(global_position.y, 95.0, 409.0)
		