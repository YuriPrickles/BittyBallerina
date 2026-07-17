@tool
class_name Map
extends Node2D
@onready var levels_node: Node2D = $Levels

var levels:Array[Level]

var normalized_rotation: int:
	get:
		if not Main.main.map: return 0
		else: return normalized_rotation

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not Engine.is_editor_hint():
		Main.main.map = self
		for child in levels_node.get_children():
			levels.append(child)
		Main.main.get_player().initialize_player()
#@onready var very_background: CanvasLayer = $CanvasLayer/VeryBackground
var added = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not added:
		added = true
		
		if not Engine.is_editor_hint():
			var level_cover:LevelCover = preload("res://Source/level_cover.tscn").instantiate()
			level_cover.levels = levels
			$CanvasLayer.add_child(level_cover)

	if Engine.is_editor_hint():
		(get_node("CanvasModulate") as CanvasModulate).hide()
	else:
		normalized_rotation = Main.normalize_rotation(rotation_degrees)
		(get_node("CanvasModulate") as CanvasModulate).show()
		rotation_degrees = roundi(rotation_degrees) % 360
		#very_background.rotation = deg_to_rad(roundi(rad_to_deg(very_background.rotation)) % 360)
		$CanvasLayer.rotation = deg_to_rad(roundi(rad_to_deg($CanvasLayer.rotation)) % 360)
		$CanvasLayer/CanvasLayer.rotation = deg_to_rad(roundi(rad_to_deg($CanvasLayer/CanvasLayer.rotation)) % 360)
	pass
