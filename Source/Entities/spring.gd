class_name Spring
extends Area2D

@onready var collider: CollisionShape2D = $Collider


func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	queue_redraw()
	pass

func _on_body_entered(body: Node2D) -> void:
	if body is Player and not body.StateMachine == Player.State.ROTATING and not body.StateMachine == Player.State.RESPAWNING:
		body = body as Player
		var final_rotation = Main.normalize_rotation(rotation_degrees + Main.main.map.rotation_degrees)
		var bop = false
		if (final_rotation - 90) % 180 == 0:
			body.position = position
			bop = true
		body.spins =body.MAX_SPINS
		body.override_vel(Vector2(0,-300).rotated(deg_to_rad(final_rotation)),0.2)
		if bop:
			body.velocity.y = -150

func _draw() -> void:
	if collider:
		draw_rect(Rect2(collider.position - collider.shape.size/2,collider.shape.size),Color.AQUA)
