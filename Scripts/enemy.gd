extends CharacterBody2D

@export var bullet: PackedScene
@export var max_shot: int
@onready var shoot_point: Marker2D = %Marker2D
@onready var cooldown: Timer = $Cooldown
@onready var enemy_sight: RayCast2D = $RayCast2D
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var destroyed: AnimationPlayer = $AnimationPlayer
@onready var despawn_timer: Timer = $Despawn_timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if $RayCast2D.is_colliding() and max_shot == 0:
		cooldown.start()
		print("Detected")
		var bulletInstance = bullet.instantiate()
		get_parent().add_child(bulletInstance)
		bulletInstance.global_position = shoot_point.global_position
		max_shot += 1
	else:
		pass


func _on_hitbox_area_entered(_area: Area2D) -> void:
	die()
	pass # Replace with function body.


func die():
	var death_sound = preload("res://Scenes/death_sound.tscn").instantiate()
	death_sound.global_position = global_position
	get_tree().current_scene.add_child(death_sound)
	death_sound.play()
	$Despawn_timer.start()
	pass

func _on_cooldown_timeout() -> void:
	print("Timer Up")
	max_shot = 0
	pass # Replace with function body.

func _on_despawn_timer_timeout() -> void:
	pass # Replace with function body.
