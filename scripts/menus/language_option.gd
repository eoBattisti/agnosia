extends OptionButton

# Called when the node enters the scene tree for the first time.
func _ready():
	item_selected.connect(_on_item_selected)
	
	select(int(GlobalManager.language))


func _on_item_selected(index: int) -> void:
	GlobalManager._set_language(index)
