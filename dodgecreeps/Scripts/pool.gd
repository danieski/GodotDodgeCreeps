extends Node
class_name Pool

#Los boloques de nuestra pool

class Poolable:
	var availability : bool
	var element : Node
	func _init(_element : Node, _availability : bool) -> void:
		availability = _availability
		element = _element

var _pool : Array[Poolable] = []

#Inizializa la pool lo que le da el tipo de objeto que va a almacenar y la cantidad
func initialize(scene : PackedScene, size : int) -> void:
	#Comprobaciones
	assert(scene != null, "Pool: provided scene is null")
	assert(size > 0, "Pool: provided size is invalid")
	assert(_pool.size() == 0, "Pool: initializing a non-empty pool")
	
	for i : int in size:
		_pool.append(Poolable.new(scene.instantiate(), true))
		
#Devuelve el primer objeto de la pool

func get_element() -> Node:
	for poolable : Poolable in _pool:
		if poolable.availability:
			poolable.availability = false
			return poolable.element
	assert(false, "Pool->get_element: no elements available")
	return null
	
#Devuelve el objeto a la pool


func return_element(element: Node) -> void:
	for poolable : Poolable in _pool:
		if poolable.element == element:
			assert(not poolable.availability, "Pool->return_element: returned element was already available")
			poolable.availability = true
			return
	assert(false, "Pool->get_element: returned element does not belong to current pool")
	
#Vacia la pool

func dispose() -> void:
	for poolable : Poolable in _pool:
		poolable.element.queue_free()
	_pool.clear()
