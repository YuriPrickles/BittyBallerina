@tool
class_name  Refill
extends Area2D

##Time it takes to respawn once collected.
@export var wait_time:float = 1.5
##Whether this Refill disappears until respawning or when the room is reloaded.
@export var one_use:bool = false
@onready var sprite: AnimatedSprite2D = $Sprite
@onready var break_audio: AudioStreamPlayer2D = $BreakAudio
@onready var respawn_audio: AudioStreamPlayer2D = $RespawnAudio

var timer:float = 0
var empty = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer = wait_time
	if not Engine.is_editor_hint():
		await Main.main.map_setup_complete
		var plr:Player = Main.main.get_player()
		plr.reset_room.connect(restore.bind(false))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not Engine.is_editor_hint():
		if Main.main.should_update(self):
			sprite.rotation_degrees = -Main.main.map.rotation_degrees
			if timer < wait_time:
				timer += delta
			elif empty:
				restore()
			if empty:
				sprite.play("empty")
			else:
				sprite.play("idle")
				for body in get_overlapping_bodies():
					if body is Player and body.spins < body.MAX_SPINS and not empty and not body.StateMachine == Player.State.ROTATING:
						body.spins = body.MAX_SPINS
						timer = 0
						if one_use:
							hide()
							timer = -9999999999999999
						empty = true
						(body as Player).camera_shake(2,4,delta)
						break_audio.play()
						Main.main.freeze(delta * 5)
		else:
			if empty:
				restore(false)
			$PointLight2D.hide()
		sprite.offset.y = sin(Engine.get_frames_drawn() * 0.04)

func restore(playsound=true):
	timer = wait_time
	show()
	if playsound: respawn_audio.play()
	empty = false


func _on_body_entered(body: Node2D) -> void:
	pass
