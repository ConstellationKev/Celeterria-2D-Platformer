extends Control

@onready var button: AudioStreamPlayer2D = $button
@onready var win: AudioStreamPlayer2D = $win

func _ready() -> void:
	win.play()

func _on_button_pressed() -> void:
	button.play()
	await button.finished
	get_tree().change_scene_to_file("res://main.tscn")
