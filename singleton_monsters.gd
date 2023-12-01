extends Node

# SHADER FADE IN OR FADE OUT AND STOP

@onready var icon = ["res://icon.svg"]

# FALSE = transparent to opaque
# TRUE  = opaque to transparent
var monster_shader_fade_in_out = true


func _ready():
	monster_shader_fade()
	monster_textures(forest_0)
	monster_mesh(6.5)
	
	
func _process(delta):
	if monster_shader_fade_over==false:
		monster_shader_fade_to_transparent_and_stop(delta)
		monster_shader_fade_to_opaque_and_stop(delta)


func monster_show(_show:bool):
	var show = _show
	if show:
		monster_shader_fade_over = false
		monster_shader_fade_in_out = false
	else:
		monster_shader_fade_over = false
		monster_shader_fade_in_out = true


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
		ALPHA *= my_color.a * my_color.a;
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
	mesh_instance.transform.origin = Vector3(0, 0, -3.0) # do Y plane_size/2 for origin at bottom
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
#	print("to transparent, monster_shader_fade_in_out is: ", monster_shader_fade_in_out)	
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
#	print("to opaque, monster_shader_fade_in_out: ", monster_shader_fade_in_out)
	if fade <= 0.0:
		fade = 0.0
		monster_shader_fade_in_out = true
		monster_shader_fade_over=true	
	monster_material.set_shader_parameter("fade", fade)


@onready var forest_0 = ["res://assets/monsters/forest_monsters_0/0001.png", "res://assets/monsters/forest_monsters_0/0002.png", "res://assets/monsters/forest_monsters_0/0003.png", "res://assets/monsters/forest_monsters_0/0004.png", "res://assets/monsters/forest_monsters_0/0005.png", "res://assets/monsters/forest_monsters_0/0006.png", "res://assets/monsters/forest_monsters_0/0007.png", "res://assets/monsters/forest_monsters_0/0008.png", "res://assets/monsters/forest_monsters_0/0009.png", "res://assets/monsters/forest_monsters_0/0010.png", "res://assets/monsters/forest_monsters_0/0011.png", "res://assets/monsters/forest_monsters_0/0012.png", "res://assets/monsters/forest_monsters_0/0013.png", "res://assets/monsters/forest_monsters_0/0014.png", "res://assets/monsters/forest_monsters_0/0015.png", "res://assets/monsters/forest_monsters_0/0016.png", "res://assets/monsters/forest_monsters_0/0017.png", "res://assets/monsters/forest_monsters_0/0018.png", "res://assets/monsters/forest_monsters_0/0019.png", "res://assets/monsters/forest_monsters_0/0020.png", "res://assets/monsters/forest_monsters_0/0021.png", "res://assets/monsters/forest_monsters_0/0022.png", "res://assets/monsters/forest_monsters_0/0023.png", "res://assets/monsters/forest_monsters_0/0024.png", "res://assets/monsters/forest_monsters_0/0025.png"]
@onready var forest_1 = ["res://assets/monsters/forest_monsters_1/0001.png", "res://assets/monsters/forest_monsters_1/0002.png", "res://assets/monsters/forest_monsters_1/0003.png", "res://assets/monsters/forest_monsters_1/0004.png", "res://assets/monsters/forest_monsters_1/0005.png", "res://assets/monsters/forest_monsters_1/0006.png", "res://assets/monsters/forest_monsters_1/0007.png", "res://assets/monsters/forest_monsters_1/0008.png", "res://assets/monsters/forest_monsters_1/0009.png", "res://assets/monsters/forest_monsters_1/0010.png", "res://assets/monsters/forest_monsters_1/0011.png", "res://assets/monsters/forest_monsters_1/0012.png", "res://assets/monsters/forest_monsters_1/0013.png", "res://assets/monsters/forest_monsters_1/0014.png", "res://assets/monsters/forest_monsters_1/0015.png", "res://assets/monsters/forest_monsters_1/0016.png", "res://assets/monsters/forest_monsters_1/0017.png", "res://assets/monsters/forest_monsters_1/0018.png", "res://assets/monsters/forest_monsters_1/0019.png", "res://assets/monsters/forest_monsters_1/0020.png", "res://assets/monsters/forest_monsters_1/0021.png", "res://assets/monsters/forest_monsters_1/0022.png", "res://assets/monsters/forest_monsters_1/0023.png", "res://assets/monsters/forest_monsters_1/0024.png", "res://assets/monsters/forest_monsters_1/0025.png"]
@onready var forest_2 = ["res://assets/monsters/forest_monsters_2_diff/5d55c27d-92db-4606-84fd-942adacbf9c4.png", "res://assets/monsters/forest_monsters_2_diff/5e33b79d-0f6f-4c4a-a8f3-0403c55da074.png", "res://assets/monsters/forest_monsters_2_diff/6cc65be3-9573-47d7-8d80-4264b12594b5.png", "res://assets/monsters/forest_monsters_2_diff/8e1f9a03-cf7e-4e5c-a8a1-72349e8c185c.png", "res://assets/monsters/forest_monsters_2_diff/8ed1cd74-eb36-4eb4-b343-33a7824ef1eb.png", "res://assets/monsters/forest_monsters_2_diff/87e153ca-0e91-47ad-9c2f-6110a0d3e06f.png", "res://assets/monsters/forest_monsters_2_diff/ae99efed-fab9-4d49-903c-a60682702214.png", "res://assets/monsters/forest_monsters_2_diff/b37d52f4-72c7-4542-b04b-6226385858c7.png", "res://assets/monsters/forest_monsters_2_diff/c3d5305d-9d0e-4c78-a758-1cd1769a3fc7.png", "res://assets/monsters/forest_monsters_2_diff/ef1ace7f-51e5-40ae-985e-76fc6b24190c.png", "res://assets/monsters/forest_monsters_2_diff/f2a3e91b-e400-4272-a473-8cea340a9aa7.png", "res://assets/monsters/forest_monsters_2_diff/f5aadbed-a349-4651-afc8-1568fb108544.png"]

@onready var experience = ["res://assets/characters/sage.png"]

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
