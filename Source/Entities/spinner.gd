@tool
class_name Spinner
extends Area2D

@onready var circle_collider: CollisionShape2D = $CircleCollider
@onready var rect_collider: CollisionShape2D = $RectCollider

enum Sizes {
	##Corresponds to [code]01.png[/code]
	Small = 1,
	##Corresponds to [code]02.png[/code]
	Medium = 2,
	##Corresponds to [code]04.png[/code]
	Giant = 4
}

@export var size:Sizes = Sizes.Small
##The spinner will not rotate when set to "Zilch".
@export_enum("Zilch:0","Clockwise:1", "Counter-Clockwise:-1") var dir:int = 1
##Name of folder in [code]res://Assets/Gameplay/objects/spinners/[/code][br][br]
##Place the sprites for the different spinner sizes as:[br]
##[code]01.png[/code] - Small[br]
##[code]02.png[/code] - Medium[br]
##[code]04.png[/code] - Giant[br]
@export var folder_name:String = "gear"
var texture:Texture2D = load("res://Assets/Gameplay/objects/spinners/%s/01.png" % folder_name)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	texture = load("res://Assets/Gameplay/objects/spinners/%s/0%s.png" % [folder_name, size])
	if size == Sizes.Small:
		(circle_collider.shape as CircleShape2D).radius = (9 * size) - (size * 3)
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
