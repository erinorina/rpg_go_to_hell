extends Node3D
@onready var singleton = Singleton
@onready var singleton_monsters = SingletonMonsters
@onready var singleton_level = SingletonLevels

@onready var exploration_crypt = ["res://exploration/crypt/001.png"]
func _ready():
#		singleton.switch_to_hud_scene()
		singleton.switch_to_scene("res://hud/hud.tscn")
		
		singleton_monsters.monster_textures(exploration_crypt)
		singleton_monsters.monster_show(true)
		
		singleton.player_stats["key"] = true
		print("you found the key for the gate to hell")
		await get_tree().create_timer(5).timeout
		hide_monster_and_quit()
		
		
func hide_monster_and_quit():
		singleton_monsters.monster_show(false)
		singleton_level.switch_to_scene("plain")
		self.queue_free()



'''
func _ready():
#	singleton.switch_to_hud_scene()
	singleton.switch_to_scene("res://hud/hud.tscn")
	singleton_monsters.monster_textures(singleton_monsters.experience)
	singleton_monsters.monster_show(true)



func _on_reading_mouse_entered():
	singleton_monsters.monster_textures(experience_reading)
	
func _on_reading_pressed():
	print("Reading a book")
	singleton.player_stats["xp"] = max(singleton.player_stats["xp"] + 1, 0)
	print ("Book read, Exp +1")
	
	singleton_monsters.monster_show(false)
	singleton_level.switch_to_scene("plain")
	
	self.queue_free()



func _on_health_potion_mouse_entered():
	singleton_monsters.monster_textures(experience_health)

func _on_health_potion_pressed():
	singleton.player_stats["life"] = max(singleton.player_stats["life"] + 25, 0)
	
	singleton_monsters.monster_show(false)
	singleton_level.switch_to_scene("plain")
	self.queue_free()



func _on_attack_training_mouse_entered():
	singleton_monsters.monster_textures(experience_attack)
	
func _on_attack_training_pressed():
	singleton.player_stats["attack"] = max(singleton.player_stats["attack"] + 1, 0)
	
	singleton_monsters.monster_show(false)
	singleton_level.switch_to_scene("plain")
	self.queue_free()

	
	
func _on_return_pressed():
	print("experience gain return -> menu")
	singleton.switch_to_scene("res://main/menu.tscn")
	self.queue_free()



@onready var experience_reading = ["res://assets/experience/reading/002.png"]
@onready var experience_health = ["res://assets/experience/health/001.png"]
@onready var experience_attack = ["res://assets/experience/attack/001.png"]

'''
