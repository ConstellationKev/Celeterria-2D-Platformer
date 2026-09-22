extends Control
@onready var lobbymusic = $lobbymusic
@onready var startbutton = $startbutton
@onready var fade: ColorRect = $CanvasLayer2/ColorRect
@onready var button: AudioStreamPlayer2D = $button

func _ready() -> void:
	fade.visible = false
	
func _on_button_pressed() -> void:
	startbutton.play()
	button.play()
	
	fade.visible = true
	fade.modulate.a = 0.0
	
	var tween = create_tween()
	tween.tween_property(fade, "modulate:a", 1.0, 1)
	
	await tween.finished
	get_tree().change_scene_to_file("res://scenes/main.tscn")
	
