extends CharacterBody2D
const SPEED = 100
const JUMP_VELOCITY = -300.0

var dead = false
var can_move = true

@onready var animated_spirte = $AnimatedSprite2D
@onready var jump: AudioStreamPlayer2D = $jump
@onready var death: AudioStreamPlayer2D = $death

func respawn():
	#self.visible = false
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://game_over.tscn")
	self.global_position = Vector2(0,0)
	#animated_spirte.play("idle")
	#await get_tree().create_timer(0.5).timeout
	dead = false
	can_move = true
	#self.visible = true
	#can_move = true
	
func _physics_process(delta: float) -> void:
	if can_move == false or dead == true:
		if dead:
			animated_spirte.play("dead")
			dead = false
		return
	else:
		# Checking for ALL collisions
		for i in get_slide_collision_count():
			var collision = get_slide_collision(i)
			if collision.get_collider().name == "TileMapSpikes":
				if not dead:
					death.play()
					dead = true
					can_move = false
					#collision = null
					respawn()
			if collision.get_collider().name == "TileMapWin":
				await get_tree().create_timer(0.2).timeout
				get_tree().change_scene_to_file("res://win.tscn")
				self.global_position = Vector2(0,0)
		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		if not dead:
			if not is_on_floor():
				animated_spirte.play("jump")
				velocity += get_gravity() * delta

			if Input.is_action_just_pressed("jump") and is_on_floor():
				jump.play()
				velocity.y = JUMP_VELOCITY

			var direction := Input.get_axis("left", "right")
			if direction:
				if is_on_floor(): 
					animated_spirte.play("walk")
				velocity.x = direction * SPEED
				animated_spirte.flip_h = (direction== -1)
			else:
				if is_on_floor(): 
					animated_spirte.play("idle")
				velocity.x = move_toward(velocity.x, 0, SPEED)
		
		
		
		
		

	move_and_slide()
