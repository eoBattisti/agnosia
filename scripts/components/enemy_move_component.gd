extends Node

@export var enemy: Enemy
@export var raycast_right: RayCast2D
@export var raycast_left: RayCast2D
@export var raycast_down_left: RayCast2D
@export var raycast_down_right: RayCast2D

var direction: float
var last_direction: float

func _detected_player_right() -> bool:
	if enemy.friendly:
		return false

	if raycast_right.is_colliding() and raycast_right.get_collider() is Player:
		return true
	return false

func _detected_player_left() -> bool:
	if enemy.friendly:
		return false
	
	if raycast_left.is_colliding() and raycast_left.get_collider() is Player:
		return true
	return false

func _detect_fall() -> bool:
	if (!raycast_down_left.is_colliding()
		or !raycast_down_right.is_colliding()):
			return true
	return false

func get_wander_time() -> float:
	return randf()

func get_random_direction() -> float:
	last_direction = direction
	direction = randi_range(-1, 1)

	if enemy.is_on_wall():
		return -last_direction

	if !raycast_down_left.is_colliding():
		return -last_direction
	
	if !raycast_down_right.is_colliding():
		return -last_direction

	return direction
