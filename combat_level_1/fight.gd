extends Node3D

@onready var singleton = Singleton
@onready var singleton_monsters = SingletonMonsters
@onready var dice_result = $attack_result/dice_result
@onready var monster_stats_damage = $stats_monster/damage

func _ready():
	singleton.switch_to_hud_scene()

func _process(_delta):
	$stats_monster/hit_range.text = str("Hit Range ", monster_stats_attack())
	$stats_player/hit_range.text = str("Hit Range ", player_stats_attack())	
	
	
	if singleton.player_stats["life"] == 0:
		singleton.switch_to_combat_loss_scene()
		self.queue_free()
	
	
	if singleton.player_stats.level < 1:
		monster_stats_damage.text = str("Damage ", MONSTER_HIT_FORCE_0)
		
	if singleton.player_stats.level >= 1 and singleton.player_stats.level <=2:
		monster_stats_damage.text = str("Damage ", MONSTER_HIT_FORCE_1)
		
	if singleton.player_stats.level >= 2:
		monster_stats_damage.text = str("Damage ", MONSTER_HIT_FORCE_2)
	

func _on_escape_pressed():
	print("fight escape -> menu")
	singleton.switch_to_exploration_plain()
	self.queue_free()	
	
func _on_attack_pressed():
	$stats_player.hide()
	$stats_monster.hide()
	$combat/attack.hide()
	$combat/escape.hide()	
	
	if singleton.player_stats.level < 1:
		fight_monster("res://assets/monsters/forest_monsters_0/0001.png", MONSTER_HIT_FORCE_0, 1)

	if singleton.player_stats.level >= 1 and singleton.player_stats.level <=2:
		fight_monster("res://assets/monsters/forest_monsters_0/0002.png", MONSTER_HIT_FORCE_1, 2)

	if singleton.player_stats.level >= 2:
		fight_monster("res://assets/monsters/forest_monsters_0/0003.png", MONSTER_HIT_FORCE_2, 3)


		

const MONSTER_HIT_FORCE_0 = 4
const MONSTER_HIT_FORCE_1 = 9
const MONSTER_HIT_FORCE_2 = 19

func fight_monster(_texture_path: String, monster_hit_force: int, player_xp_gain: int):
	roll_dice_and_determine_winner(monster_hit_force)
	if is_player_winner:
		experience_gain(player_xp_gain)


var is_player_winner: bool
func roll_dice_and_determine_winner(damage_caused_by_monster: int):
	var player_attack_value = player_attack_range() 
	var monster_attack_value = monster_attack_range() 
   
	$attack_result/player_dice.text = str("Player Dice : ", player_attack_value)
	$attack_result/monster_dice.text = str("Monster Dice : ", monster_attack_value)
   
	print("Player rolled: " + str(player_attack_value))
	print("Monster rolled: " + str(monster_attack_value))

	if player_attack_value > monster_attack_value:
		is_player_winner = true
		dice_result.text = str("VICTORY !")
#		singleton.monster.hide()

	elif monster_attack_value > player_attack_value:
		is_player_winner = false
		dice_result.text = str("YOU LOSE !")
		singleton.player_stats["life"] = max(singleton.player_stats["life"] - damage_caused_by_monster, 0)

	else:
		dice_result.text = str("DRAW !")
	
	await get_tree().create_timer(3).timeout
	singleton.switch_to_exploration_plain()
	self.queue_free()
	

# PLAYER ATTACK RANGE
@onready var player_attack_max = 2 + singleton.player_stats["level"]
@onready var player_attack_min:int = 0 + singleton.player_stats["attack"]

func player_attack_range():
	# ensures that the minimum attack value is always
	# less than or equal to the maximum attack value.
	if player_attack_min > player_attack_max:
		var temp = player_attack_min
		player_attack_min = player_attack_max
		player_attack_max = temp
	return randi() % (player_attack_max - player_attack_min + 1) + player_attack_min

func player_stats_attack():
	return str(player_attack_max," - ", player_attack_min)


# MONSTER ATTACK RANGE
@onready var monster_attack_max = 2 + singleton.player_stats["level"]
@onready var monster_attack_min = 0 + singleton.player_stats["level"]

func monster_attack_range():
	if monster_attack_min > monster_attack_max:
		var temp = monster_attack_min
		monster_attack_min = monster_attack_max
		monster_attack_max = temp
	return randi() % (monster_attack_max - monster_attack_min + 1) + monster_attack_min
	
func monster_stats_attack(): # Monster Attack between scaled on the player level
	return str(monster_attack_max," - ", monster_attack_min)	
	

# EXPERIENCE GAIN ON WIN
func experience_gain(_level):
	singleton.player_stats.xp += _level
	if singleton.player_stats.xp >= 6:
		singleton.player_stats.level += 1
		singleton.player_stats.xp = 0
