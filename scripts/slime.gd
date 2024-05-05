extends Node2D

const SPEED = 30

@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_left = $RayCastLeft
@onready var animated_sprite = $AnimatedSprite2D

@export var health: int = 5
@export var damage: int = 1

var direction = 1
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if ray_cast_right.is_colliding():
		direction = -1
		animated_sprite.flip_h = true
	if ray_cast_left.is_colliding():
		direction = 1
		animated_sprite.flip_h = false	

	position.x += direction * SPEED * delta


func _on_hitbox_body_entered(body):
	body.handle_damage(damage)
