@tool
class_name TextTrigger
extends Area2D


@export var width:int = 24
@export var height:int = 24
@onready var collider: CollisionShape2D = $Collider

@export_multiline var text:String = ""

func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	collider.position = Vector2(width,height) / 2
	collider.shape.size = Vector2(width,height)


func _on_body_entered(body: Node2D) -> void:
	if body is Player and not body.StateMachine == Player.State.RESPAWNING and not body.StateMachine == Player.State.ROTATING:
		Main.ui.say(text)


func _on_body_exited(body: Node2D) -> void:
	if body is Player and not body.StateMachine == Player.State.RESPAWNING and not body.StateMachine == Player.State.ROTATING:
		Main.ui.begone.emit()
