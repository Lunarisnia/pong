extends Control
class_name ScoreBoard

@onready var home: Label = get_node("Home")
@onready var away: Label = get_node("Away")

func _on_scored(home_score: int, away_score: int) -> void:
	home.text = str(home_score)
	away.text = str(away_score)

