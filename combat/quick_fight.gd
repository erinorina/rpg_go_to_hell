extends Node3D

@onready var singleton = Singleton
@onready var image = $TextureRect
@onready var player_dice = $VBoxContainer/player_dice
@onready var monster_dice = $VBoxContainer/monster_dice
@onready var dice_result = $VBoxContainer/dice_result

var win:bool

func _ready():
	singleton.switch_to_hud_scene()

func _process(_delta):
	if singleton.player_stats["life"] == 0:
		singleton.switch_to_combat_loss_scene()
		singleton.reset_player_stats()
		self.queue_free()


func _on_m_1_pressed():
	fight_monster("forest_monsters_0", singleton.forest_monsters_0_random, 24, 1)

func _on_m_2_pressed():
	fight_monster("forest_monsters_1", singleton.forest_monsters_1_random, 49, 2)

func _on_m_3_pressed():
	fight_monster("forest_monsters_2", singleton.forest_monsters_2_random, 74, 3)

func fight_monster(message: String, texture_path: String, hit_force: int, xp_gain: int):
	print(message)
	image.texture = load(texture_path)
	roll_dice_and_determine_winner(hit_force)
	if win:
		experience_gain(xp_gain)

func _on_escape_pressed():
	print("fight escape -> menu")
	await get_tree().create_timer(0.25).timeout
	singleton.switch_to_menu_scene()
	self.queue_free()

func roll_player_dice():
	return randi() % 6 + 1

func roll_monster_dice():
	return randi() % 6 + 1

func roll_dice_and_determine_winner(_damage):
	var player_roll = roll_player_dice()
	var monster_roll = roll_monster_dice()
   
	player_dice.text = str("Player Dice : ", player_roll)
	monster_dice.text = str("Monster Dice : ", monster_roll)
   
	print("Player rolled: " + str(player_roll))
	print("Monster rolled: " + str(monster_roll))

	if player_roll > monster_roll:
		win=true
		dice_result.text = str("Player wins!")

	elif monster_roll > player_roll:
		win=false
		dice_result.text = str("Monster wins!")
		singleton.player_stats["life"] = max(singleton.player_stats["life"] - _damage, 0)

	else:
		dice_result.text = str("It's a draw!")


func experience_gain(_level):
	singleton.player_stats.xp += _level
