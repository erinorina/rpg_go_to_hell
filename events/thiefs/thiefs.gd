extends Node3D
@onready var singleton = Singleton
@onready var singleton_monsters = SingletonMonsters
@onready var singleton_level = SingletonLevels

@onready var event_thief = ["res://events/thiefs/001.png"]
func _ready():
#		singleton.switch_to_hud_scene()
		singleton.switch_to_scene("res://hud/hud.tscn")
		
		singleton_monsters.monster_textures(event_thief)
		singleton_monsters.monster_show(true)
		
		if singleton.player_stats["gold"] >=1:
			singleton.player_stats["gold"] -= 1
		else:
			singleton.player_stats["life"] -= 25
		await get_tree().create_timer(5).timeout
		hide_monster_and_quit()
		
		
func hide_monster_and_quit():
		singleton_monsters.monster_show(false)
		singleton_level.switch_to_scene("plain")
		self.queue_free()
