extends Area2D
@export var bullet_speed: int


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var move_tween = create_tween()
	move_tween.tween_property(self, "global_position", global_position + Vector2.DOWN * bullet_speed, 2)
	$CPUParticles2D.emitting = true
	pass

func _on_area_entered(area: Area2D) -> void:
	queue_free()
	pass # Replace with function body.
