class_name OverworldUI
extends Control

var map_list:Array[PackedScene] = Main.main.map_list
var selected:int = 0
var active:bool = true
@onready var test_label: RichTextLabel = $TestLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not active: return
	test_label.text = "[center][font_size=64]%s" % map_list[selected]
	pass

func _input(event: InputEvent) -> void:
	if not active: return
	if Input.is_action_just_pressed("left") or Input.is_action_just_pressed("right"):
		var input_dir = Input.get_axis("left","right")
		selected = clampi(selected + input_dir, 0, map_list.size() - 1)
		Main.main.map_to_load = map_list[selected]
	if Input.is_action_just_pressed("accept"):
		Main.main.load_map()
func appear():
	active = true
	selected = 0
	show()

func disappear():
	hide()
	active = false
	selected = 0
