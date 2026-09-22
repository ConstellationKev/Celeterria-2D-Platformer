extends Control

@onready var gameover: AudioStreamPlayer2D = $gameover
@onready var button: AudioStreamPlayer2D = $button

func _ready() -> void:
	gameover.play()

func _on_button_pressed() -> void:
	button.play()
	await button.finished
	get_tree().change_scene_to_file("res://scenes/main.tscn")
