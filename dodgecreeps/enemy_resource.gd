extends Resource

class_name enemy_type

@export var name: String
@export var speed: float
@export var type: types
@export var health: float

enum types {
	RED,
	BLUE,
	GREEN
}

func find_apparence():
	pass	
