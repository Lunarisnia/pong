extends CharacterBody2D
class_name Ball

signal exit_position(position: Vector2)
signal play_audio(audio: AudioStream, shift_pitch: bool)

@onready var collision_audio: AudioStream = preload("res://assets/Audio/collision.wav")
@onready var notifier: VisibleOnScreenNotifier2D = get_node("VisibleOnScreenNotifier2D")

const SPEED = 400.0

func start(p_position: Vector2, start_direction: float = -1.0) -> void:
	velocity = Vector2.ZERO
	global_position = p_position
	await get_tree().create_timer(1.0).timeout

	var direction: Vector2 = Vector2(start_direction, randi_range(-1, 1))
	if direction.y == 0.0:
		direction.y = -1
	direction = direction.normalized()
	velocity = direction * SPEED

func _physics_process(delta: float) -> void:
	var collision: KinematicCollision2D = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.bounce(collision.get_normal())
		play_audio.emit(collision_audio, true)

func _on_exited() -> void:
	exit_position.emit(global_position)
	velocity = Vector2.ZERO

func _on_restart(ball_position: Vector2, _home_position: Vector2, _away_position: Vector2, start_direction: float):
	start(ball_position, start_direction)

