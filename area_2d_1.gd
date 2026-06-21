extends Area2D

@onready var sound: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision: CollisionShape2D = $CollisionShape2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		sound.play()
		collision.set_deferred("disabled", true)
		sprite.hide()
		await sound.finished
		queue_free()
