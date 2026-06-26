class_name Main
extends Node

@export var map:Map

enum Depths{
	LevelCover = 99,
	Player  = 0,
	Entities = -1,
	FGTiles = -2,
	BGTiles = -3,
	VeryBackground = -99,
}

static var ui: UI


static var main:Main

const VOID_COLOR:Color = Color("ffffffff")

func _init() -> void:
	main = self

func _ready() -> void:
	ui = $UI

func _process(delta: float) -> void:
	get_window().content_scale_size = Vector2(0, 0)

func get_player() -> Player:
	return map.get_node("Player")

func should_update(entity:Node) -> bool:
	return get_player().current_level == (entity.get_parent() as Level)

static func normalize_rotation(degrees:float) -> int:
	if roundi(degrees) == 360: return 0
	var initial_normalized = (roundi(degrees) % 360)
	if initial_normalized < 0: initial_normalized += 360
	return initial_normalized

func freeze(time:float):
	get_tree().paused = true
	await get_tree().create_timer(time).timeout
	get_tree().paused = false
