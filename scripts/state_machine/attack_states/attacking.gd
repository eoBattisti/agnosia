extends State
class_name AttackAttackingState

@export var charging_state: State
@export var hitbox: AttackHitbox

var hitbox_colision_shape: CollisionShape2D
var is_complete: bool = false

func enter() -> void:
	hitbox_colision_shape = hitbox.get_child(0)
	hitbox_colision_shape.disabled = false
	hitbox.connect("area_entered", process_damage)
	is_complete = false
	super()
	await animations.animation_finished
	is_complete = true
	hitbox_colision_shape.disabled = true

func process_frame(delta: float) -> State:
	if parent.velocity.x < 0:
		animations.flip_h = true
	elif parent.velocity.x > 0:
		animations.flip_h = false

	if is_complete:
		return charging_state
	return null

func process_damage(area: Area2D) -> void:
	if area is HitboxComponent:
		var enemy = area.get_parent()
		if enemy is Enemy:
			enemy.friendly = false
		var attack = Attack.new()
		attack.damage = 1
		area.damage(attack)
