extends Area2D

@onready var sprite = $Sprite2D
@onready var camera = %Camera2D
@onready var animation_player = $AnimationPlayer
@onready var collision = $CollisionShape2D
@onready var timer = $Timer

var start = false
var pos
var camera_pos
var t = 0.0
func _ready():
	pos = sprite.global_position
func _process(delta):
	
	if start == true:
		lerp_transform(delta)
		
func lerp_transform(delta):
	if sprite.global_position > camera.global_position:
		t += delta * 1
		sprite.global_position = lerp(pos,camera.global_position,t)
		
	else:
		start = false
		print("reparent")
		sprite.reparent(camera)
		animation_player.reparent(camera)
		animation_player.play("zoom")
		timer.start()

		
func _on_body_entered(body):
	collision.queue_free()
	start = true
	print("interact")
	sprite.z_index = 6
	#sprite.reparent(camera)
	#animation_player.reparent(camera)
	#animation_player.play("zoom")
	#sprite.position.y = -20
	#sprite.scale.x = 2.5
	#sprite.scale.y = 2.5
	


func _on_timer_timeout():
	get_tree().quit()
