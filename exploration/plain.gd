extends Node3D
@onready var singleton=Singleton
@onready var singleton_monsters=SingletonMonsters
@onready var singleton_dice = SingletonDice
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

	
func _on_return_pressed():
	print("experience gain return -> menu")
	singleton.switch_to_scene("res://main/menu.tscn")
	self.queue_free()
	
	
var last_level:int = -1
func _process(delta):
	var current_level = singleton.player_stats["level"]
	if current_level != last_level:
		last_level = current_level
#		init_world_from_player_level()
#		switch_worlds()
	
	match travel_state:
		TravelState.IDLE:
			moved_full_distance = false
			
		TravelState.ROLLING:
			singleton_dice.travel()
			travel_state = TravelState.ADVANCING

		TravelState.ADVANCING:
			singleton_monsters.monster_show(false)
			move_ground_on_dice_roll(singleton_dice.travel_distance, delta)

			if moved_full_distance:
				travel_state = TravelState.COMBAT

		TravelState.COMBAT:
			print("combat")
			roll_events(delta)
			travel_state = TravelState.IDLE


func move_ground_on_dice_roll(_player_roll,_delta):
	print("advancing ", _player_roll)
	await get_tree().create_timer(2).timeout
	moved_full_distance = true


# EVENTS
func roll_events(_delta):
	$VBoxContainer.hide()

	if singleton_dice.travel_distance == 1:
		print("find treasure, win gold")
		singleton.switch_to_scene("res://events/treasure/treasure.tscn")

	if singleton_dice.travel_distance == 2:
		print("Ambush from thiefs loose gold or life if no gold")
		singleton.switch_to_scene("res://events/thiefs/thiefs.tscn")

	if singleton_dice.travel_distance == 3 :
		print("Combats: loose life if loss, win xp if win")
		singleton.switch_to_scene("res://combat_level_1/fight.tscn")

	if singleton_dice.travel_distance == 4:
		print("gift stats choice: xp, attack, health")
		singleton.switch_to_scene("res://experience/gain.tscn")

	if singleton_dice.travel_distance == 5:
		if singleton.player_stats["gold"] !=0:
			print("Nomad marchant buy armor, sword, health")
			singleton.switch_to_scene("res://merchant/shop.tscn")
		else:
			print("if no gold, normal combat")
			singleton.switch_to_scene("res://combat_level_1/fight.tscn")


	if singleton_dice.travel_distance == 6:
		print("Combat, to replace by direction choice")
		singleton.switch_to_scene("res://combat_level_1/fight.tscn")
	
	self.queue_free()
#	
