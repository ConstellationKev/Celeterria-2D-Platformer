extends CharacterBody2D


@onready var animated_sprite = $AnimatedSprite2D


func _physics_process(delta: float) -> void:
	animated_sprite.play("default")
