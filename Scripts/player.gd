extends CharacterBody2D
@export var speed: int
@export var projectiles: PackedScene
var max_per_shot: int
var game_over: PackedScene = preload("res://Scenes/restart.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var direction = Input.get_axis("left", "right")
	move_and_slide()
	position.x += direction * speed * delta
	
	if Input.is_action_pressed("left"):
		%AnimationPlayer.play("left")
	elif Input.is_action_pressed("right"):
		%AnimationPlayer.play("right")
	else:
		%AnimationPlayer.play("static")
		pass
	
	if Input.is_action_just_pressed("shoot") and max_per_shot == 0:
		var shot_audio: int = randi_range(1, 2)
		if shot_audio == 1:
			%Shoot.stream = preload("res://Assets/SFX/Laser_shot.mp3")
			%Shoot.play()
		else:
			%Shoot.stream = preload("res://Assets/SFX/Laser_shot2.mp3")
			%Shoot.play()
			pass
		var rocket = projectiles.instantiate()
		get_parent().add_child(rocket)
		rocket.global_position = %Marker2D.global_position
		max_per_shot += 1
		%Cooldown.start()
	pass

func _on_cooldown_timeout() -> void:
	max_per_shot = 0
	pass # Replace with function body.
	

func _on_hurtbox_area_entered(area: Area2D) -> void:
	%Death_sound.play()
	var you_died = preload("res://Scenes/you_died.tscn").instantiate()
	you_died.global_position = global_position
	get_tree().current_scene.add_child(you_died)
	you_died.play()
	queue_free()
	%Restart.show()
	pass # Replace with function body.


#Back And Forth movement using AnimationPlayers if I'm struggling
#
