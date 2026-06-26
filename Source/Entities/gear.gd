@tool
class_name Gear
extends Area2D

@onready var circle_collider: CollisionShape2D = $CircleCollider
@onready var rect_collider: CollisionShape2D = $RectCollider

enum Sizes {
	Small = 1,
	Medium = 2,
	Giant = 4
}

@export var size:Sizes = Sizes.Small
@export_enum("Clockwise:1", "Counter-Clockwise:-1") var dir:int = 1
var texture:Texture2D = load("res://Assets/Gameplay/objects/gears/gear_1.png")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	texture = load("res://Assets/Gameplay/objects/gears/gear_%s.png" % size)
	if size == Sizes.Small:
		(circle_collider.shape as CircleShape2D).radius = (9 * size) - (size * 2)
		(rect_collider.shape as RectangleShape2D).size = Vector2(16 * size, 2 * size)
	else:
		(circle_collider.shape as CircleShape2D).radius = (8 * size) - (size * 1)
		(rect_collider.shape as RectangleShape2D).size = Vector2(16 * size, 2 * size)
	if not Engine.is_editor_hint():
		if Main.main.should_update(self):
			rect_collider.rotation_degrees = Main.main.map.normalized_rotation
			if texture:
				queue_redraw()
	else:
		if texture:
			queue_redraw()
	

func _draw() -> void:
	draw_set_transform(Vector2.ZERO,Engine.get_frames_drawn() * 0.01 * size * dir)
	draw_texture(texture, -Vector2(8 * size,8 * size))

func _on_body_entered(body: Node2D) -> void:
	if body is Player and body is not StaticBody2D:
		if body.StateMachine == Player.State.ROTATING: return
		if not body.StateMachine == Player.State.RESPAWNING:
			body.respawn()
