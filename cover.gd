extends Area2D
class_name Cover
var rotate_timer: int
var hits_taken: int
var active: bool = true
@export var despawn_particles: PackedScene
@onready var enemy_cover: AnimationPlayer = $AnimationPlayer
signal victory

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
		rotate_timer = randi_range(1, 4)
		var move_tween = create_tween()
		move_tween.set_loops()
		move_tween.tween_property(self, "rotation_degrees", 360, rotate_timer).as_relative()
		pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_emit_particles_up_area_entered(area: Area2D) -> void:
	if active or hits_taken != 3:
		%Bullet_Hit_up.emitting = true
		hits_taken += 1
		$AnimationPlayer.play("impact")
		stop_rotate()
		%Resume_Rotate_Timer.start()
	if hits_taken == 3:
		active == false
		%Resume_Rotate_Timer.stop()
		$AnimationPlayer.play("cover_destroyed")
		$Sprite2D.rotation_degrees = 0
		print("DESTROYEDDDD")
		%Despawn_Timer.start()
	pass # Replace with function body.


func _on_emit_particles_left_area_entered(area: Area2D) -> void:
	if active or hits_taken != 3:
		%Bullet_Hit_left.emitting = true
		hits_taken += 1
		$AnimationPlayer.play("impact")
		stop_rotate()
		%Resume_Rotate_Timer.start()
	if hits_taken == 3:
		%Resume_Rotate_Timer.stop()
		$AnimationPlayer.play("cover_destroyed")
		$Sprite2D.rotation_degrees = 0
		print("DESTROYEDDDD")
		%Despawn_Timer.start()
	pass # Replace with function body.


func _on_emit_particles_right_area_entered(area: Area2D) -> void:
	if active or hits_taken != 3:
		%Bullet_Hit_right.emitting = true
		hits_taken += 1
		$AnimationPlayer.play("impact")
		stop_rotate()
		%Resume_Rotate_Timer.start()
	if hits_taken == 3:
		%Resume_Rotate_Timer.stop()
		$AnimationPlayer.play("cover_destroyed")
		$Sprite2D.rotation_degrees = 0
		print("DESTROYEDDDD")
		%Despawn_Timer.start()
	pass # Replace with function body.


func _on_emit_particles_bottom_area_entered(area: Area2D) -> void:
	if active or hits_taken != 3:
		%Bullet_Hit_bottom.emitting = true
		hits_taken += 1
		$AnimationPlayer.play("impact")
		stop_rotate()
		%Resume_Rotate_Timer.start()
	if hits_taken == 3:
		%Resume_Rotate_Timer.stop()
		$AnimationPlayer.play("cover_destroyed")
		$Sprite2D.rotation_degrees = 0
		print("DESTROYEDDDD")
		%Despawn_Timer.start()
	pass # Replace with function body.

func stop_rotate():
	var rotate_stop = create_tween()
	rotate_stop.tween_property(self, "rotation_degrees", 0, rotate_timer).as_relative()
	pass

func _on_resume_rotate_timer_timeout() -> void:
	_ready()
	pass # Replace with function body.

func _on_despawn_timer_timeout() -> void:
	$".".queue_free()
	pass # Replace with function body.

func _on_victory_despawn_timeout() -> void:
	$AnimationPlayer.stop()
	$".".queue_free()
	pass # Replace with function body.


func _on_enemy_victory() -> void:
	%Victory_Despawn.start()
	$AnimationPlayer.play("Victory_screen")
	pass # Replace with function body.


func _on_enemy_2_victory() -> void:
	%Victory_Despawn.start()
	$AnimationPlayer.play("Victory_screen")
	pass # Replace with function body.
