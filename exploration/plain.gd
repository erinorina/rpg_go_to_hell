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

func _ready():
	singleton.switch_to_forest()
#	dice_values = fisher_yates_shuffle(dice_values)
	
func _on_traveling_pressed():
	if travel_state == TravelState.ADVANCING:
		return
	travel_state = TravelState.ROLLING
	
	
func _on_return_pressed():
	print("experience gain return -> menu")
	singleton.switch_to_menu_scene()
	self.queue_free()
	
	
var last_level:int = -1
func _process(delta):
	var current_level = singleton.player_stats["level"]
	if current_level != last_level:
		last_level = current_level
#		init_world_from_player_level()
		switch_worlds()
	
	match travel_state:
		TravelState.IDLE:
			moved_full_distance = false

		TravelState.ROLLING:
			
			travel()
			
			travel_state = TravelState.ADVANCING

		TravelState.ADVANCING:
			singleton_monsters.monster_show(false)
			move_world(delta)
#			move_ground_on_dice_roll(travel_distance, delta)
			if moved_full_distance:
				travel_state = TravelState.COMBAT

		TravelState.COMBAT:
			switch_monsters_textures()
			singleton_monsters.monster_show(true)
			roll_events(delta)
			travel_state = TravelState.IDLE



# DICE LOGIC FOR TRAVELING , without repeats between rolls
var travel_distance:int
var dice_current_values = [1,2,3,4,5,6]
var dice_next_values = [6,5,4,3,2,1]
var dice_index:int=5
func travel():
	dice_index +=1
	if dice_index >= dice_current_values.size():
		dice_current_values.shuffle()
		dice_next_values.shuffle()
		while dice_current_values[5]==dice_next_values[0]:
			dice_next_values.shuffle()
		if dice_current_values[5]!=dice_next_values[0]:
			dice_next_values=dice_current_values
		dice_index = 0
	travel_distance = dice_current_values[dice_index-1]
	print("travel_distance ",travel_distance)
	return travel_distance
	
	
func move_ground_on_dice_roll(_player_roll,_delta):
	print("advancing", _player_roll)
	await get_tree().create_timer(2).timeout
	moved_full_distance = true


# WORLD MOVE
var start_position:Vector3
var end_position:Vector3
var current_world:Node3D
func move_world(_delta):
	print("moving...")
	var speed = 1.0
	
	if current_world:
		end_position = start_position + Vector3(0, 0, travel_distance) * speed
		current_world.transform.origin += Vector3(0, 0, speed) * _delta
		if current_world.transform.origin.distance_to(end_position) < speed * _delta:
			current_world.transform.origin = start_position
			print("moved")
			moved_full_distance = true
		
	
# WORLDS SWITCH
func switch_worlds():
	if singleton.player_stats.level ==0:
		singleton.switch_to_forest()
		current_world = singleton.forest_scene_instance
	if singleton.player_stats.level ==1:
		singleton.clear_forest()
		singleton.switch_to_hell()
		current_world = singleton.hell_scene_instance
		
		
# MONSTERS TEXTURES SWITCH
func switch_monsters_textures():
	if singleton.player_stats.level ==0:
		print("switch_monsters_textures level 0")
		singleton_monsters.monster_textures(singleton_monsters.forest_0)
	if singleton.player_stats.level ==1:
		print("switch_monsters_textures level 1")
		singleton_monsters.monster_textures(singleton_monsters.forest_1)
	if singleton.player_stats.level >=2:
		print("switch_monsters_textures level 2")
		singleton_monsters.monster_textures(singleton_monsters.forest_2)
		
# EVENTS
func roll_events(_delta):
	$VBoxContainer.hide()

	if travel_distance == 1:
		print("find treasure")
		singleton.switch_to_event_treasure_scene()

		
	if travel_distance == 2:
		print("Ambush from thiefs if Combat lost , loose gold, if win , win golds")
		singleton.switch_to_event_thief_scene()

	if travel_distance == 3 :
		print("Normal Combats Level 1, loose life if loss")
		singleton.switch_to_combat_level_1_scene()
		
	if travel_distance == 4:
		print("- experience stats, attack, health")
#		singleton_monsters.monster_textures(singleton_monsters.experience)
		singleton.switch_to_experience_scene()

	if travel_distance == 5:
		if singleton.player_stats["gold"] !=0:
			singleton.switch_to_merchant_shop_scene()
		else:
			singleton.switch_to_combat_level_1_scene()


	if travel_distance == 6:
		print("- Moment of clarity! Study your skills to permanently increase one stat")
		singleton.switch_to_combat_level_1_scene()

