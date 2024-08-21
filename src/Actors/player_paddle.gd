extends CharacterBody2D
class_name Player

const PADDLE_SPEED = 300.0

var allowed_to_move: bool = false

func start(p_position: Vector2) -> void:
    global_position = p_position
    await get_tree().create_timer(1.0).timeout
    allowed_to_move = true

func _physics_process(delta: float) -> void:
    if allowed_to_move:
        var direction: Vector2 = -Vector2.UP * Input.get_axis("move_up", "move_down")

        velocity = direction * PADDLE_SPEED * delta

        # var collided: KinematicCollision2D = move_and_collide(velocity)
        move_and_collide(velocity)

func _on_restart(_ball_position: Vector2, home_position: Vector2, _away_position: Vector2, _start_direction: float):
    allowed_to_move = false
    start(home_position)

