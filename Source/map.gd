@tool
class_name Map
extends Node2D

@export var levels:Array[Level]

var normalized_rotation: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not Engine.is_editor_hint():
		for l:Level in levels:
			var level_cover:LevelCover = preload("res://Source/level_cover.tscn").instantiate()
			level_cover.level = l
			level_cover.position = l.position
			l.level_cover = level_cover
			$VeryBackground.add_child(level_cover)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		(get_node("CanvasModulate") as CanvasModulate).hide()
	else:
		normalized_rotation = Main.normalize_rotation(rotation_degrees)
		(get_node("CanvasModulate") as CanvasModulate).show()
		rotation_degrees = roundi(rotation_degrees) % 360
		$VeryBackground.rotation = deg_to_rad(roundi(rad_to_deg($VeryBackground.rotation)) % 360)
		$VeryBackground2.rotation = deg_to_rad(roundi(rad_to_deg($VeryBackground2.rotation)) % 360)
	pass
