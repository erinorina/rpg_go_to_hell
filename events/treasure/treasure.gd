extends Node3D
@onready var singleton = Singleton
@onready var singleton_monsters = SingletonMonsters


@onready var event_treasure = ["res://events/treasure/001.png"]
func _ready():
		singleton.switch_to_hud_scene()
		singleton_monsters.monster_textures(event_treasure)
		singleton_monsters.monster_show(true)
		singleton.player_stats["gold"] += 3
		await get_tree().create_timer(5).timeout
		hide_monster_and_quit()
		
		
func hide_monster_and_quit():
		singleton_monsters.monster_show(false)
		singleton.switch_to_exploration_plain()
		self.queue_free()
