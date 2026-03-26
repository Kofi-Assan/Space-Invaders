extends Area2D
@export var speed: int 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var fired_rocket = create_tween()
	fired_rocket.tween_property(self, "global_position", global_position + Vector2.UP * speed,  1)
	$CPUParticles2D.emitting = true
	#fired_rocket.tween_property(self, "global_position", Vector2.LEFT * 10, 1)
	#fired_rocket.tween_property(self, "global_position", Vector2.RIGHT * 10, .5)
	pass

func _on_area_entered(area: Area2D) -> void:
	$".".queue_free()
	pass # Replace with function body.
