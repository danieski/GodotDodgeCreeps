extends Resource
class_name enemy_type

@export var name: String
@export var type: types

@export var speed: float
@export var point: float

enum types {
	RED,
	BLUE,
	GREEN
}
func find_apparcence():
	print("FindAparence")
	var color : Color
	match type:
		0:
			color = Color(1,0.14,0,1)
		1: 
			color = Color(0,0.53,0.95,1)
		2:
			color = Color(0,0.85,0.45,1) 
	return color
