extends Node3D

@onready var singleton = Singleton

func _process(_delta):
	if singleton.player_stats["life"] == 0:
		self.queue_free()
		
	$HBoxContainer/life.text = "Life: " + str(round(singleton.player_stats["life"])) + " | "
	$HBoxContainer/xp.text = "XP: " + str(round(singleton.player_stats["xp"])) + " | "
	$HBoxContainer/level.text = "Level: " + str(round(singleton.player_stats["level"])) + " | "
	$HBoxContainer/attack.text = "Attack: " + str(round(singleton.player_stats["attack"])) + " | "
	$HBoxContainer/gold.text = "Gold: " + str(round(singleton.player_stats["gold"])) + " | "
