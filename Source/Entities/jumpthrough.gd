@tool
class_name Jumpthrough
extends StaticBody2D

@onready var collider: CollisionShape2D = $Collider

@export var width:int = 8
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	collider.shape.size = Vector2(width,8)
	collider.position = Vector2(width,8) / 2
	queue_redraw()

func _draw() -> void:
	draw_rect(Rect2(Vector2.ZERO,Vector2(width,4)),Color.GOLD)
