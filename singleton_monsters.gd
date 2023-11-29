extends Node

# SHADER FADE IN OR FADE OUT AND STOP

@onready var icon = ["res://icon.svg"]

# FALSE = transparent to opaque
# TRUE  = opaque to transparent
var monster_shader_fade_in_out = true


func _ready():
	monster_shader_fade()
	monster_textures(forest_0)
	monster_mesh(2.0)
	
	
func _process(delta):
	if monster_shader_fade_over==false:
		monster_shader_fade_to_transparent_and_stop(delta)
		monster_shader_fade_to_opaque_and_stop(delta)


var monster_material:ShaderMaterial
func monster_shader_fade():
	monster_material = ShaderMaterial.new()
	var shader_code = """
	shader_type spatial;
	render_mode unshaded;
	
	uniform float fade;
	
	uniform sampler2D my_texture;

	void fragment() {
		vec4 my_color = texture(my_texture, UV);
		vec4 fade_color = vec4(my_color.rgb, 0.0);
		my_color = mix(my_color, fade_color, fade);
		ALBEDO = my_color.rgb;
		ALPHA = my_color.a;
	}
	"""

	var shader = Shader.new()
	shader.code = shader_code
	monster_material.shader = shader


func monster_textures(_textures_array):
	var texture_path = _textures_array[randi() % _textures_array.size()]
	var texture = ResourceLoader.load(texture_path)
	if texture:
		monster_material.set_shader_parameter("my_texture", texture)
	else:
		print("Failed to load texture:", texture_path)
		
		
func monster_mesh(plane_size:float= 2.0):
	# Create a new PlaneMesh
	var plane_mesh = PlaneMesh.new()
	plane_mesh.size = Vector2(plane_size, plane_size)
	var mesh_instance = MeshInstance3D.new()
	mesh_instance.mesh = plane_mesh
	# Transform the mesh_instance
	mesh_instance.rotation.x = deg_to_rad(90)
	mesh_instance.transform.origin = Vector3(0, plane_size/2, -3.0)
	# Assign the ShaderMaterial to the MeshInstance3D
	mesh_instance.set_material_override(monster_material)
	# Add the MeshInstance3D to the scene
	add_child(mesh_instance)
	return mesh_instance
	
	
var fade = 0.0 # opaque / default
var fade_speed = 0.6
var fade_direction = 1.0 	
var monster_shader_fade_over=false
func monster_shader_fade_to_transparent_and_stop(_delta:float):
	if monster_shader_fade_in_out==false:
		return
	if monster_shader_fade_in_out==true and fade ==1.0:
		fade=0.0
	fade += fade_speed * _delta * fade_direction
	print("to transparent, monster_shader_fade_in_out is: ", monster_shader_fade_in_out)
	if fade >= 1.0:
		fade = 1.0
		monster_shader_fade_in_out = false	
		monster_shader_fade_over=true		
	monster_material.set_shader_parameter("fade", fade)
	
		
func monster_shader_fade_to_opaque_and_stop(_delta:float):
	if monster_shader_fade_in_out==true:
		return
	if monster_shader_fade_in_out==false and fade ==0.0:
		fade=1.0
	fade -= fade_speed * _delta * fade_direction
	print("to opaque, monster_shader_fade_in_out: ", monster_shader_fade_in_out)
	if fade <= 0.0:
		fade = 0.0
		monster_shader_fade_in_out = true
		monster_shader_fade_over=true	
	monster_material.set_shader_parameter("fade", fade)


@onready var forest_0 = ["res://assets/monsters/forest_monsters_0/0001.png", "res://assets/monsters/forest_monsters_0/0002.png", "res://assets/monsters/forest_monsters_0/0003.png", "res://assets/monsters/forest_monsters_0/0004.png", "res://assets/monsters/forest_monsters_0/0005.png", "res://assets/monsters/forest_monsters_0/0006.png", "res://assets/monsters/forest_monsters_0/0007.png", "res://assets/monsters/forest_monsters_0/0008.png", "res://assets/monsters/forest_monsters_0/0009.png", "res://assets/monsters/forest_monsters_0/0010.png", "res://assets/monsters/forest_monsters_0/0011.png", "res://assets/monsters/forest_monsters_0/0012.png", "res://assets/monsters/forest_monsters_0/0013.png", "res://assets/monsters/forest_monsters_0/0014.png", "res://assets/monsters/forest_monsters_0/0015.png", "res://assets/monsters/forest_monsters_0/0016.png", "res://assets/monsters/forest_monsters_0/0017.png", "res://assets/monsters/forest_monsters_0/0018.png", "res://assets/monsters/forest_monsters_0/0019.png", "res://assets/monsters/forest_monsters_0/0020.png", "res://assets/monsters/forest_monsters_0/0021.png", "res://assets/monsters/forest_monsters_0/0022.png", "res://assets/monsters/forest_monsters_0/0023.png", "res://assets/monsters/forest_monsters_0/0024.png", "res://assets/monsters/forest_monsters_0/0025.png"]
'''
var monster_material:ShaderMaterial
func _ready():
	monster_shader()
	monster_textures(forest_0)
	monster_mesh(2.0)
	monster_instance.visible = false
	
	
#var accumulated_time = 0.0
#func _process(delta):
#	accumulated_time += delta
#	if accumulated_time >= 2.0:
#		monster_textures(forest_0)
#		accumulated_time = 0.0


func monster_shader():
	# Create a new ShaderMaterial
	monster_material = ShaderMaterial.new()
	var shader_code = """
	shader_type spatial;
	render_mode unshaded;
	uniform sampler2D my_texture;

	void fragment() {
		vec4 my_color = texture(my_texture, UV);
		ALBEDO = my_color.rgb;
		ALPHA = my_color.a;
	}
	"""
	# Create a new Shader and assign the shader code to it
	var shader = Shader.new()
	shader.code = shader_code

	# Assign the Shader to the ShaderMaterial
	monster_material.shader = shader


func monster_textures(_textures_array):
	var texture_path = _textures_array[randi() % _textures_array.size()]
	var texture = ResourceLoader.load(texture_path)
	if texture:
		monster_material.set_shader_parameter("my_texture", texture)
	else:
		print("Failed to load texture:", texture_path)
		
var monster_instance:MeshInstance3D		
func monster_mesh(plane_size:float= 2.0):
	# Create a new PlaneMesh
	var plane_mesh = PlaneMesh.new()
	plane_mesh.size = Vector2(plane_size, plane_size)
	monster_instance = MeshInstance3D.new()
	monster_instance.mesh = plane_mesh
	# Transform the mesh_instance
	monster_instance.rotation.x = deg_to_rad(90)
	monster_instance.transform.origin = Vector3(0, plane_size/2, -3)	
	# Assign the ShaderMaterial to the MeshInstance3D
	monster_instance.set_material_override(monster_material)
	# Add the MeshInstance3D to the scene
	add_child(monster_instance)
	
	'''
