extends StaticBody2D

@onready var interaction_area = $InteractionArea
@onready var sprite = $AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	interaction_area.interact = Callable(self, "_toggle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _toggle():
	sprite.frame += 1
