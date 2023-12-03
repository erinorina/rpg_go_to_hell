extends Node


var player_stats = {
	"level": 0,
	"xp": 0,
	"life": 100,
	"attack":0,
	"gold":0
}

# RESSET PLAYER STATS
func reset_player_stats():
	player_stats["life"] = 100
	player_stats["xp"] = 0
	player_stats["level"] = 0
	player_stats["attack"] = 0


### simple scenes

var scene_instances = {}

func switch_to_scene(scene_path):
	add_scene(scene_path)
	show_scene(scene_path)

func add_scene(scene_path):
	if not scene_instances.has(scene_path) or scene_instances[scene_path] == null:
		var scene = load(scene_path)
		scene_instances[scene_path] = scene.instantiate()
		get_tree().root.add_child(scene_instances[scene_path])

func show_scene(scene_path):
	if scene_instances.has(scene_path) and scene_instances[scene_path] != null:
		scene_instances[scene_path].visible = true
		for child in scene_instances[scene_path].get_children():
			child.visible = true
	else:
		add_scene(scene_path)
