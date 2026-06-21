extends Area2D

@export var target_scene_path: String = "res://Lose.tscn"

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		set_deferred("monitoring", false)  # changed from: monitoring = false
		call_deferred("_fix")

func _fix() -> void:
	if is_inside_tree():
		get_tree().change_scene_to_file(target_scene_path)
