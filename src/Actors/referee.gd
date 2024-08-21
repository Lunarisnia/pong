extends Node
class_name Referee

signal restart(ball_position: Vector2, home_position: Vector2, away_position: Vector2, start_direction: float)
signal scored(home_score: int, away_score: int)
signal play_audio(audio: AudioStream, pitch_shift: bool)

@onready var goal_audio: AudioStream = preload("res://assets/Audio/goal.wav")

@export var kickoff_position: Marker2D
@export var home_position: Marker2D
@export var away_position: Marker2D

var home_score: int = 0
var away_score: int = 0

func _ready():
    restart.emit(kickoff_position.global_position, home_position.global_position, away_position.global_position, -1.0)

func _on_ball_exit_position(position: Vector2) -> void:
    var start_direction: float = 0.0
    if position.x < 0.0:
        away_score += 1
        start_direction = -1.0
    else:
        home_score += 1
        start_direction = 1.0
    restart.emit(kickoff_position.global_position, home_position.global_position, away_position.global_position, start_direction)
    scored.emit(home_score, away_score)
    play_audio.emit(goal_audio, true)

func _pause_game(status: bool):
    get_tree().paused = status

func _on_pause_menu_game_paused(status:bool) -> void:
    _pause_game(status)

func _on_pause_menu_reset_game() -> void:
    restart.emit(kickoff_position.global_position, home_position.global_position, away_position.global_position, -1.0)
    home_score = 0
    away_score = 0
    scored.emit(home_score, away_score)

