extends Area2D

func _on_body_entered(body):
	print(body)
	if body is Player:
		body.die()
