extends Node

func _ready():
	create_camera()




func _process(delta):
	pass
	
	
func create_camera():
	var camera = Camera3D.new()
	add_child(camera)
	camera.global_transform.origin = Vector3(0, 0, 0)
	camera.look_at(Vector3(0, 0, -4), Vector3.UP)
	camera.current = true
	
#func create_camera():
#	var camera = Camera3D.new()
#	add_child(camera)
#	camera.global_transform.origin = Vector3(0, 0, 0)
#	camera.projection = Camera3D.PROJECTION_ORTHOGONAL
#	camera.set_orthogonal(10, 0.1, 1000)
#	camera.current = true

