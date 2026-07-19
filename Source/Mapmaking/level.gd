@tool
class_name Level
extends Node2D
@export var bounds:Rect2
@export var foreground_tiles: TileMapLayer
var true_bounds:Rect2:
	get:
		return Rect2(bounds.position,bounds.size * 16)

var cover_opacity:float = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	foreground_tiles = get_node("ForegroundTiles")
	foreground_tiles.z_index = Main.Depths.FGTiles


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		bounds.position = position
		queue_redraw()
	else:
		queue_redraw()

func get_nearest_respawn(pos:Vector2):
	var distance = INF
	var respawn:Respawn = null
	for node in get_children():
		if node is Respawn:
			print(node.name + ": " + str(node.position.distance_to(pos - position)))
			if node.position.distance_to(pos - position) < distance:
				distance = node.position.distance_to(pos - position)
				respawn = node
	assert(respawn, "No respawn found in the room :( its me im the room hi im really sad about this please put at least one (1) respawn inside me :(")
	print("respawning at: ", respawn.name, " ",respawn.position)
	return respawn

func _draw() -> void:
	if Engine.is_editor_hint():
		draw_rect(Rect2(Vector2.ZERO,true_bounds.size),Color.ORANGE,false,3)
