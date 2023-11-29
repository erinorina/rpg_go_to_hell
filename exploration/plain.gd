extends Node3D
@onready var singleton=Singleton
@onready var singleton_monsters=SingletonMonsters

@onready var player_dice = $VBoxContainer/player_dice

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
#			singleton_monsters.monster_shader_fade_in_out = false
			moved_full_distance = false

		TravelState.ROLLING:
			singleton_monsters.monster_shader_fade_over = false
			singleton_monsters.monster_shader_fade_in_out = true
#			singleton_monsters.monster_shader_fade_in_out = true
#			singleton_monsters.monster_instance.visible = false
#			singleton.monster.hide()
			travel()
			travel_state = TravelState.ADVANCING

		TravelState.ADVANCING:
			singleton_monsters.monster_shader_fade_over = false
			singleton_monsters.monster_shader_fade_in_out = true
#			singleton_monsters.monster_shader_fade_in_out = true
			move_ground_on_dice_roll(travel_distance, delta)
			if moved_full_distance:
				travel_state = TravelState.COMBAT

		TravelState.COMBAT:
			singleton_monsters.monster_shader_fade_over = false
			singleton_monsters.monster_shader_fade_in_out = false
#			singleton_monsters.monster_textures(singleton_monsters.forest_0)
#			singleton_monsters.monster_instance.visible = true
#			singleton.monster.show()		
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
		singleton_monsters.monster_textures(singleton_monsters.forest_0)

	if singleton.player_stats.level >= 1 and singleton.player_stats.level <=2 :
		singleton_monsters.monster_textures(singleton_monsters.forest_0)

	if singleton.player_stats.level >= 2:
		singleton_monsters.monster_textures(singleton_monsters.forest_0)

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

		singleton.switch_to_experience_scene()

	if travel_distance == 5:
		print("- Lucky find! Stumble upon a chest of buried treasure in the dirt.")
		singleton.switch_to_combat_level_1_scene()

	if travel_distance == 6:
		print("- Moment of clarity! Study your skills to permanently increase one stat")
		singleton.switch_to_combat_level_1_scene()

