extends Node3D
@onready var singleton=Singleton
@onready var player_dice = $VBoxContainer/player_dice

func _ready():
#	init_world_from_player_level()
	singleton.monster.hide()
	
enum TravelState {
IDLE,
ROLLING,
ADVANCING,
COMBAT
}

var travel_state = TravelState.IDLE
var moved_full_distance = false

func _on_traveling_pressed():
	if travel_state == TravelState.ADVANCING:
		return
	travel_state = TravelState.ROLLING
	
	
var last_level:int = -1
func _process(delta):
	var current_level = singleton.player_stats["level"]
	if current_level != last_level:
		last_level = current_level
		init_world_from_player_level()
	
	match travel_state:
		TravelState.IDLE:
			moved_full_distance = false

		TravelState.ROLLING:

			singleton.monster.hide()
			travel()
			travel_state = TravelState.ADVANCING

		TravelState.ADVANCING:
			move_ground_on_dice_roll(travel_distance, delta)
			if moved_full_distance:
				travel_state = TravelState.COMBAT

		TravelState.COMBAT:
			singleton.monster.show()		
			roll_events(delta)
			travel_state = TravelState.IDLE



var travel_distance:int

func travel():
	travel_distance = randi() % 6 + 1
	player_dice.text = str("Travel Distance : ", travel_distance)

	return travel_distance

# MOVE GROUND BASED ON DICE ROLL NUMBER(need to add infinite runner mechanic)
var speed = 1.0
var end_position:Vector3
func move_ground_on_dice_roll(_player_roll,_delta):
	if box:
		end_position = start_position + Vector3(0, 0, _player_roll) * speed
		box.transform.origin += Vector3(0, 0, speed) * _delta
		if box.transform.origin.distance_to(end_position) < speed * _delta:
			box.transform.origin = start_position
			moved_full_distance = true




func _on_return_pressed():
	print("experience gain return -> menu")
	singleton.switch_to_menu_scene()
	self.queue_free()


'''
# POP UP MONSTER

@onready var start_position_monster = monster.transform.origin
var speed_m = 1.0
var monster_up = false
func move_monster_up(_unit, _delta):
	if monster:
		var end_position = start_position_monster + Vector3(0, _unit, 0) * speed_m
		monster.transform.origin += Vector3(0, speed_m, 0) * _delta
		if monster.transform.origin.distance_to(end_position) < speed_m * _delta:
			monster.transform.origin = end_position
			monster_up = false
			
			await get_tree().create_timer(3).timeout
			monster.transform.origin = start_position_monster
'''






#@onready var monster = $assets/monster	
func change_monster_texture(new_texture_path):
	var new_texture = load(new_texture_path)
	print ("monster path ", singleton.monster.get_path()) # is /root/plain/assets/monster
	var mesh_instance = singleton.monster.get_node("monster2")
	print ("monster  mesh", mesh_instance) # is monster2:<MeshInstance3D#36339451158>
	if mesh_instance is MeshInstance3D:
		var mesh = mesh_instance.mesh
		var material = mesh.surface_get_material(0)
		if material is StandardMaterial3D:
			material.albedo_texture = new_texture
			material.blend_mode = StandardMaterial3D.BLEND_MODE_MIX
			material.transparency = 0.5
			material.depth_draw_mode = StandardMaterial3D.DEPTH_DRAW_ALWAYS
			material.albedo_color = Color(1,1,1,1)
			material.alpha_scissor_threshold = 0.5
			material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
#			material.flags_unshaded = StandardMaterial3D.FLAG_ALBEDO_FROM_VERTEX_COLOR
			material.transparency = StandardMaterial3D.TRANSPARENCY_ALPHA_SCISSOR
#			material.transparency = StandardMaterial3D.TRANSPARENCY_ALPHA_DEPTH_PRE_PASS



# PICK A WORLD FROM PLAYER LEVEL
var box:Node
var start_position:Vector3
@onready var forest = $forest
func init_world_from_player_level():
	forest.hide()
	$assets/hell.hide()
	box = pick_world_from_player_level()
	box.show()
	start_position = box.transform.origin

func pick_world_from_player_level():
	if singleton.player_stats["level"] <= 1:
		return forest
	else:
		return $assets/hell

# EVENTS
func roll_events(_delta):
	$VBoxContainer.hide()
	if singleton.player_stats.level < 1:
		if singleton.forest_monsters_0_random !=null:
			change_monster_texture(singleton.forest_monsters_0_random)
		else:
			print("bug start in plain.gd fuck 1/2 singleton.forest_monsters_0_random is null")
		
	if singleton.player_stats.level >= 1 and singleton.player_stats.level <=2 :
		if singleton.forest_monsters_0_random !=null:
			change_monster_texture(singleton.forest_monsters_1_random)
		else:
			print("bug start in plain.gd fuck 1/2 singleton.forest_monsters_1_random is null")
			
	if singleton.player_stats.level >= 2:
		if singleton.forest_monsters_0_random !=null:
			change_monster_texture(singleton.forest_monsters_2_random)
		else:
			print("bug start in plain.gd fuck 1/2 singleton.forest_monsters_2_random is null")
	
	if travel_distance == 1:
		print("Trap loose one object, armor, shield, helmet")
		singleton.switch_to_combat_level_1_scene()

	if travel_distance == 2:
		print("Ambush from thiefs if Combat lost , loose gold, if win , win golds")
		singleton.switch_to_combat_level_1_scene()

	if travel_distance == 3 :
		print("Normal Combats Level 1, loose life if loss")
		singleton.switch_to_combat_level_1_scene()
		
	if travel_distance == 4:
		print("- Sage in the woods offers advice. Pay to learn a spell or skill, or keep walking?")
		change_monster_texture("res://assets/characters/sage.png")
		singleton.switch_to_experience_scene()

	if travel_distance == 5:
		print("- Lucky find! Stumble upon a chest of buried treasure in the dirt.")
		singleton.switch_to_combat_level_1_scene()

	if travel_distance == 6:
		print("- Moment of clarity! Study your skills to permanently increase one stat")
		singleton.switch_to_combat_level_1_scene()

