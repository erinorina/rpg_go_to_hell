extends Node3D
@onready var singleton = Singleton
@onready var singleton_monsters = SingletonMonsters


@onready var merchant_character = ["res://assets/merchant/character/001.png"]
func _ready():
		singleton.switch_to_hud_scene()
		singleton_monsters.monster_textures(merchant_character)
		singleton_monsters.monster_show(true)

	
	
func _on_return_pressed():
	hide_monster_and_quit()



@onready var merchant_shop_armor = ["res://assets/merchant/shop/armor/001.png"]
func _on_armor_mouse_entered():
	singleton_monsters.monster_textures(merchant_shop_armor)
func _on_armor_pressed():
	if singleton.player_stats["gold"] >=3:
		singleton.player_stats["gold"] -= 3
		
		print("armor buyed life + 100")
		singleton.player_stats["life"] += 100

		hide_monster_and_quit()

	else:
		print("Not enought money")


@onready var merchant_shop_sword = ["res://assets/merchant/shop/sword/001.png"]
func _on_sword_mouse_entered():
	singleton_monsters.monster_textures(merchant_shop_sword)
func _on_sword_pressed():
	if singleton.player_stats["gold"] >=2:
		singleton.player_stats["gold"] -= 2	
		
		print("Sword buyed Attack + 2")
		singleton.player_stats["attack"] += 2

		hide_monster_and_quit()
	else:
		print("Not enought money")


@onready var merchant_shop_health_potion = ["res://assets/merchant/shop/health_potion/001.png"]
func _on_health_potion_mouse_entered():
	singleton_monsters.monster_textures(merchant_shop_health_potion)


func _on_health_potion_pressed():
	if singleton.player_stats["gold"] >=1:
		singleton.player_stats["gold"] -= 1	
		
		print("health_potion buyed life + 25")
		singleton.player_stats["life"] += 25

		hide_monster_and_quit()
	else:
		print("Not enought money")



func hide_monster_and_quit():
		singleton_monsters.monster_show(false)
		singleton.switch_to_exploration_plain()
		self.queue_free()
