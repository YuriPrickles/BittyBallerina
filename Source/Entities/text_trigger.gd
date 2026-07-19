@tool
class_name TextTrigger
extends Area2D


@export var width:int = 24
@export var height:int = 24
@onready var collider: CollisionShape2D = $Collider
##The text that will be shown on the UI upon entering this trigger.
@export_multiline var text:String = ""

func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	collider.position = Vector2(width,height) / 2
	collider.shape.size = Vector2(width,height)
	if Engine.is_editor_hint():
		queue_redraw()


func _on_body_entered(body: Node2D) -> void:
	if body is Player and not body.StateMachine == Player.State.RESPAWNING and not body.StateMachine == Player.State.ROTATING:
		Main.ui.say(text)


func _on_body_exited(body: Node2D) -> void:
	if body is Player and not body.StateMachine == Player.State.ROTATING:
		Main.ui.begone.emit()

func _draw() -> void:
	if Engine.is_editor_hint():
		draw_string(ThemeDB.fallback_font,Vector2(width/4,height)/2,"Text",HORIZONTAL_ALIGNMENT_CENTER,-1, 6)
		draw_string(ThemeDB.fallback_font,Vector2(width/8,height/2 + 8),"Trigger",HORIZONTAL_ALIGNMENT_CENTER,-1, 6)
